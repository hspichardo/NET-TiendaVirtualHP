using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TiendaVirutalHarlynPichardoO.Models;

namespace TiendaVirutalHarlynPichardoO.Controllers
{
    public class ClientesController : Controller
    {
        private TiendaVirutalHarlynPichardoOEntities db = new TiendaVirutalHarlynPichardoOEntities();





        // GET: Clientes/Create
        public ActionResult Create()
        {

            //Cliente c = (from cli in db.Clientes
            //             where cli.Email.Equals(User.Identity.Name)
            //             select cli).First();
            var res = (from cli in db.Clientes
                       where cli.Email.Equals(User.Identity.Name)
                       select cli);
            Cliente c = new Cliente();
            if (res.Count() != 0)
            {
                c = res.First();
            }
            else
            {
                c = new Cliente();
                c.Email = User.Identity.Name;
            }
            return View(c);
        }

        // POST: Profile/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Nombre,Email,Direccion")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                var res = (from cli in db.Clientes
                           where cli.Email.Equals(User.Identity.Name)
                           select cli);
                if (res.Count() == 0)
                {
                    
                    cliente.Email = User.Identity.Name;
                    db.Clientes.Add(cliente);
                    
                }

                else
                {
                    Cliente c = res.First();
                    c.Nombre = cliente.Nombre;
                    c.Email = User.Identity.Name;
                    c.Direccion = cliente.Direccion;
                }
                db.SaveChanges();
                return RedirectToAction("Index", "Home", null);
            }

            return View(cliente);
        }

        // GET: Clientes/Edit/5
       
    }
}
