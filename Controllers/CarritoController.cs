using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TiendaVirutalHarlynPichardoO.Models;

namespace ProyectoM.Controllers
{
    public class CarritoController : Controller
    {
        // GET: Carrito
        public ActionResult Index(CarritoCompra cc)
        {
            return View(cc);
        }

        public ActionResult Add(CarritoCompra cc, Productos p)
        {

            cc.Add(p);
            return View("Index", cc);
        }
        public ActionResult Comprar(CarritoCompra cc)
        {
            ModelTIendaVirutalContainer db = new ModelTIendaVirutalContainer();
            Pedidos ped = new Pedidos();
            foreach (Productos pi in cc)
            {
                Productos pe = db.Productos.Find(pi.Id);
                pe.Cantidad--;
                ped.Productos.Add(pe);
                cc.Remove(pi);
            }
            db.Pedidos.Add(ped);
            db.SaveChanges();
            return View("Index", cc);
        }
    }
}