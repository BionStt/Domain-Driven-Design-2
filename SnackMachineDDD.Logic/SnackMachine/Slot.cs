﻿using SnackMachineDDD.logic.Common;

namespace SnackMachineDDD.logic.SnackMachine
{
    /***********************************************************************************************************************************************
     - Snack,Quantity,Price are always used together so we could extract them into SnackPile abstraction
     - All responsibilities of the slot entity had been transferred to the SnackPile value object (light weight). 
       The Slot acts just as a host for that value object, nothing more. 
     - To adhere to the immutability rule of value objects. Instead of making the quantity property in the SnackPile ValueObject mutable, 
       a separate method that creates a new instance of that value object had been introduce.     
     ************************************************************************************************************************************************/
    public class Slot: Entity
    {
        //public virtual Snack Snack { get;  set; }
        //public virtual int Quantity { get;  set; }
        //public virtual decimal Price { get;  set; }
        public virtual SnackMachine SnackMachine { get; protected set; }
        public virtual  int Position { get;  set; }
        public virtual SnackPile SnackPile { get; set; }
        protected Slot(){}
        public Slot(SnackMachine snackMachine, int position)
        //public Slot(SnackMachine snackMachine, int position, Snack snack, int quantity, decimal price)
            : this()
        {
           
            SnackMachine = snackMachine;
            Position = position;
            //Snack = snack ;
            //Quantity = quantity;
            //Price = price;
            //SnackPile = new SnackPile(Snack.None, 0, 0m);
            SnackPile = SnackPile.EmptySnackPile;
        }
    }
}
