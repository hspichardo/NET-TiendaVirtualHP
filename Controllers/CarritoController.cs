﻿using System;
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

        public ActionResult Add(CarritoCompra cc, Producto product)
        {
            if (cc.Exists(p => p.Id == product.Id))
            {
                Producto pi = cc.Find(p => p.Id == product.Id);
                if (product.Cantidad > pi.Cantidad)
                {
                    pi.Cantidad++;
                }
                else
                {
                    return RedirectToAction("Index");
                }

            }
            else
            {
                product.Cantidad = 1;
                cc.Add(product);
            }
            
            return View("Index", cc);
        }
        public ActionResult Comprar(CarritoCompra cc)
        {
            TiendaVirutalHarlynPichardoOEntities db = new TiendaVirutalHarlynPichardoOEntities();
            Pedido ped = new Pedido();
            var res = (from cli in db.Clientes
                       where cli.Email.Equals(User.Identity.Name)
                       select cli);
            Cliente c = res.First();

            ped.Cliente = c;

            foreach (Producto pi in cc)
            {
                Producto pe = db.Productos.Find(pi.Id);
                pe.Cantidad = pe.Cantidad - pi.Cantidad;
                db.Entry(pe).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();

                ProductosPedido pp = new ProductosPedido();
                pp.Pedido = ped;
                pp.Producto = pe;
                pp.Cantidad = pi.Cantidad;
                db.ProductosPedidos.Add(pp);

            }
            for (int i = 0; i<cc.Count(); i++)
            {
                cc.RemoveAt(i);
               
            }
            
            

           
            db.SaveChanges();
            return View("Index", cc);
        }
    }
}