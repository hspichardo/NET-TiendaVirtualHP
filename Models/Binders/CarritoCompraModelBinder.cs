using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TiendaVirutalHarlynPichardoO.Models.Binders
{
    public class CarritoCompraModelBinder : IModelBinder
    {
        public static string key_carrito = "KEY_123_CARRITO";
        public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            CarritoCompra c = (CarritoCompra)controllerContext.HttpContext.Session[key_carrito];
            if (c == null)
            {
                c = new CarritoCompra();
                controllerContext.HttpContext.Session[key_carrito] = c;
            }

            return c;
        }
    }
}