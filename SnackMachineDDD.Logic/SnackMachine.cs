﻿using System;
using System.Collections.Generic;
using System.Linq;
using static SnackMachineDDD.logic.Money;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  We should isolate our domain model from the persistence logic as much as possible, 
  it's not always feasible when using an ORM, we still need to adapt the domain layer and some persistence logic leaks 
  into the domain model. Luckily, the degree of the leak is not too big (un-sealed class + virtual + Getype pb with lazy loading), 
  and the tradeoff made is worth it. we still preserve a lot of isolation for our domain model. For example, 
  we didn't have to change any of the existing tests that validate our domain classes. 
  So it is possible to maintain the same high degree of isolation even in larger projects.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
namespace SnackMachineDDD.logic
{
    /***************************************************************************************************
     SnackMachine is fully encapsulated aggregate,i.e. it doesn't expose its internals to other aggregates. 
     Not only its hides the collection of the slots, but also its keeps the internal Slot entity inside 
     the aggregate and don't expose it to the outside world, such a degree of isolation (is of paramount importance) 
     had been introduced by relying on new value object SnackPile.      
     ****************************************************************************************************/

    //Nhibernate require all non-private members to be marked as virtual!
    public class SnackMachine : AggregateRoot
    {
        public virtual SnackPile GetSnackPile(int position)
        {
            return Slots.Single(x => x.Position == position).SnackPile;
        }

        public SnackMachine()
        {
            MoneyInside = None;
            //MoneyInTransaction = None;
            MoneyInTransaction = 0;
            Slots = new List<Slot>
            {
                new Slot(this, 1),
                new Slot(this, 2),
                new Slot(this,3),
            };
        }

        //amount of money inside the machine
        public virtual Money MoneyInside { get; protected set; }

        //amount of money in transaction
        //we might return the amount of money in different bills or cents than the ones inserted by the customer,
        //we want to track only the amount, back to decimal 
        //public virtual Money MoneyInTransaction { get; protected set; }

        public virtual decimal MoneyInTransaction { get; protected set; }
        public virtual decimal Amount { get; set; }

        /*************************************************************************************************************
         * NHibernate requires collections that are part of the mapping to be either of ICollection or IList types.
         * Here we not exposing internal Slot entity (client couldn't tamper directly with this entity)
         **************************************************************************************************************/
        protected virtual IList<Slot> Slots { get; set; }

        //public virtual void InsertMoney(Money money) => MoneyInTransaction += money;
        //public virtual void ReturnMoney() => MoneyInTransaction = None;
        public virtual void ReturnMoney()
        {
            Money moneyToRetun = MoneyInside.Allocate(MoneyInTransaction);
            MoneyInside -= moneyToRetun;
            MoneyInTransaction = 0;
        }

        public virtual void BuySnack(int position)
        {
            //Slots.Single(x => x.Position == position).Quantity--;
            var slot = GetSlot(position);
            //if (slot.SnackPile.Price > MoneyInTransaction.Amount) throw new InvalidOperationException();
            if (slot.SnackPile.Price > MoneyInTransaction) throw new InvalidOperationException();
            slot.SnackPile = slot.SnackPile.SubtractOne();

            //No longer needed the InsertMoney take care of it
            //MoneyInside += MoneyInTransaction;

            //MoneyInTransaction = None;
            Money change = MoneyInside.Allocate(MoneyInTransaction - slot.SnackPile.Price);

            if (change.Amount < MoneyInTransaction - slot.SnackPile.Price) {throw new InvalidOperationException();}

            MoneyInside -= change;
            MoneyInTransaction = 0;
        }


        public virtual void InsertMoney(Money money)
        {
            Money[] coinsAndNotes = {
                Cent,
                TenCent,
                Quarter,
                FiveDollar,
                OneDollar,
                TwentyDollar
            };

            if (!coinsAndNotes.Contains(money)) throw new InvalidOperationException();
            MoneyInTransaction += money.Amount;
            MoneyInside += money;
        }

        //public virtual void LoadSnacks(int position, Snack snack, int quantity, decimal price)
        public virtual void LoadSnacks(int position, SnackPile snackPile)
        {
            Slot slot = GetSlot(position);
            //slot.Snack = snack;
            //slot.Quantity = quantity;
            //slot.Price = price;
            slot.SnackPile = snackPile;
            slot.Position = position;
        }

        private Slot GetSlot(int position)
        {
            return Slots.Single(x => x.Position == position);
        }

        public virtual void LoadMoney(Money money)
        {
            MoneyInside += money;

        }

        public virtual string CanBuySnack(int position)
        {
            throw new NotImplementedException();
        }

        public virtual void GetAllSnackPiles()
        {
            throw new NotImplementedException();
        }



    }
}
