import { useState } from "react";
import logo from "../assets/logo.png";
import { useAuth } from "../context/useAuth";
import LoginModal from "../components/LoginModal";
import RegisterModal from "../components/RegisterModal";
import { Link, useNavigate } from "react-router-dom";
import { Avatar, Menu, Burger, Transition, rem } from '@mantine/core';
import { IconUser, IconLogout, IconChevronDown, IconChevronUp, IconHome, IconBook2, IconList, IconWorld, IconSettings, IconLogin } from '@tabler/icons-react';
import { motion } from 'framer-motion';

const headerVariants = {
  initial: { opacity: 0, y: -40, filter: 'blur(8px)' },
  animate: { opacity: 1, y: 0, filter: 'blur(0px)', transition: { duration: 0.5, ease: [0.4, 0, 0.2, 1] } },
  exit: { opacity: 0, y: -40, filter: 'blur(8px)', transition: { duration: 0.4, ease: [0.4, 0, 0.2, 1] } }
};

function Header() {
  const { nombre, logout } = useAuth();
  const [mostrarLoginModal, setMostrarLoginModal] = useState(false);
  const [mostrarRegisterModal, setMostrarRegisterModal] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [userMenuOpen, setUserMenuOpen] = useState(false);
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    setUserMenuOpen(false);
    navigate('/');
  };

  // Links de navegación extendidos (sin Inicio)
  const navLinks = [
    { to: "/dieta", label: "Generar Dieta", icon: null },
    { to: "/recetas", label: "Recetas", icon: null },
  ];
  // Menú educación mejorado
  const educacionLinks = [
    { to: "/articulos", label: "Artículos", icon: <IconBook2 size={20} />, desc: "Guías y artículos de nutrición" },
    { to: "/glosario", label: "Glosario", icon: <IconList size={20} />, desc: "Términos y conceptos clave" },
    { to: "/multimedia", label: "Recursos", icon: <IconWorld size={20} />, desc: "Vídeos, webs y apps útiles" },
  ];

  return (
    <motion.header
      className="sticky top-0 w-full z-[100] backdrop-blur-xl bg-white/70 dark:bg-gray-900/70 border-b border-emerald-100 dark:border-emerald-900 shadow-lg"
      initial="initial"
      animate="animate"
      exit="exit"
      variants={headerVariants}
      style={{
        boxShadow: '0 8px 32px 0 rgba(16, 185, 129, 0.10)',
        background: 'rgba(255,255,255,0.7)',
        WebkitBackdropFilter: 'blur(16px)',
        backdropFilter: 'blur(16px)',
      }}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-8 flex items-center justify-between h-20 relative">
        {/* Menú hamburguesa móvil */}
        <div className="flex items-center md:hidden">
          <Burger
            opened={menuOpen}
            onClick={() => setMenuOpen((o) => !o)}
            size="md"
            color="#059669"
            aria-label="Abrir menú"
            className="mr-2"
          />
        </div>
        {/* Navegación desktop mejorada */}
        <nav className="hidden md:flex items-center gap-3 flex-1 justify-between w-full">
          {/* Botones verdes a la izquierda */}
          <motion.div
            className="flex items-center gap-3 ml-2"
            initial={{ opacity: 0, x: -60 }}
            animate={{ opacity: 1, x: 0, transition: { duration: 0.7, ease: [0.4, 0, 0.2, 1] } }}
          >
            {navLinks.map((link) => (
              <motion.div
                whileHover={{ scale: 1.08 }}
                whileTap={{ scale: 1.15, y: -8, opacity: 0.8 }}
                transition={{ type: 'spring', stiffness: 500, damping: 12 }}
                key={link.to}
              >
                <Link
                  to={link.to}
                  className="px-5 py-2 rounded-full font-bold bg-gradient-to-r from-emerald-400 to-emerald-600 text-white shadow-lg hover:shadow-emerald-200 flex items-center gap-2 text-lg transition-all duration-200 border-2 border-emerald-200 hover:border-emerald-500"
                >
                  {link.icon}
                  <span>{link.label}</span>
                </Link>
              </motion.div>
            ))}
            {/* Menú Educación mejorado */}
            <Menu shadow="xl" width={280} position="bottom" withinPortal>
              <Menu.Target>
                <motion.button
                  initial={{ opacity: 0, x: -60 }}
                  animate={{ opacity: 1, x: 0, transition: { duration: 0.8, delay: 0.1, ease: [0.4, 0, 0.2, 1] } }}
                  whileHover={{ scale: 1.08 }}
                  whileTap={{ scale: 1.15, y: -8, opacity: 0.8 }}
                  transition={{ type: 'spring', stiffness: 500, damping: 12 }}
                  className="px-5 py-2 rounded-full font-bold bg-gradient-to-r from-emerald-400 to-emerald-600 text-white shadow-lg hover:shadow-emerald-200 flex items-center gap-2 text-lg transition-all duration-200 border-2 border-emerald-200 hover:border-emerald-500">
                  <IconBook2 size={20} />
                  Educación
                  <IconChevronDown size={18} className="ml-1" />
                </motion.button>
              </Menu.Target>
              <Menu.Dropdown className="rounded-2xl shadow-2xl border border-emerald-100 dark:border-emerald-900 bg-white/90 dark:bg-gray-900/90 backdrop-blur-xl p-2">
                {educacionLinks.map((l) => (
                  <Menu.Item key={l.to} component={Link} to={l.to} className="flex items-center gap-3 px-3 py-3 rounded-xl hover:bg-emerald-50 dark:hover:bg-emerald-900/40 transition-all duration-200">
                    <div className="flex-shrink-0">{l.icon}</div>
                    <div className="flex flex-col items-start">
                      <span className="font-bold text-emerald-800 dark:text-emerald-200 text-base">{l.label}</span>
                      <span className="text-xs text-gray-500 dark:text-gray-400">{l.desc}</span>
                    </div>
                  </Menu.Item>
                ))}
              </Menu.Dropdown>
            </Menu>
          </motion.div>
          {/* Logo perfectamente centrado */}
          <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 flex items-center justify-center z-10" style={{ pointerEvents: 'auto' }}>
            <Link to="/" className="group block">
              <motion.div
                whileHover={{ scale: 1.08, rotate: 3 }}
                className="border-2 border-emerald-400 rounded-full p-2 bg-white shadow-md group-hover:shadow-lg group-hover:border-emerald-500 transition-all duration-300 group-hover:scale-110"
              >
                <img
                  src={logo}
                  alt="Logo BioNut"
                  className="h-14 w-auto transition-transform duration-300 group-hover:rotate-6"
                />
              </motion.div>
            </Link>
          </div>
          {/* Botones a la derecha del logo */}
          <motion.div
            className="flex items-center gap-3 ml-auto"
            initial={{ opacity: 0, x: 60 }}
            animate={{ opacity: 1, x: 0, transition: { duration: 0.9, delay: 0.2, ease: [0.4, 0, 0.2, 1] } }}
          >
            {/* Botón Foro mejorado */}
            <motion.div
              whileHover={{ scale: 1.08 }}
              whileTap={{ scale: 1.15, y: -8, opacity: 0.8 }}
              transition={{ type: 'spring', stiffness: 500, damping: 12 }}
            >
              <Link
                to="/foro"
                className="px-5 py-2 rounded-full font-bold bg-gradient-to-r from-cyan-400 to-cyan-600 text-white shadow-lg hover:shadow-cyan-200 flex items-center gap-2 text-lg transition-all duration-200 border-2 border-cyan-200 hover:border-cyan-500"
              >
                <IconWorld size={20} />
                Foro
              </Link>
            </motion.div>
            {/* Avatar/Login */}
            <div className="flex items-center gap-2 ml-2">
              {nombre ? (
                <Menu
                  opened={userMenuOpen}
                  onChange={setUserMenuOpen}
                  shadow="xl"
                  width={220}
                  position="bottom-end"
                  transitionProps={{ transition: 'pop', duration: 200 }}
                  withinPortal
                >
                  <Menu.Target>
                    <motion.div
                      whileHover={{ scale: 1.08 }}
                      whileTap={{ scale: 1.15, y: -8, opacity: 0.8 }}
                      transition={{ type: 'spring', stiffness: 500, damping: 12 }}
                    >
                      <Avatar
                        color="teal"
                        radius="xl"
                        size={44}
                        className="cursor-pointer border-2 border-emerald-400 shadow-md hover:scale-105 transition-transform duration-200"
                        onClick={() => setUserMenuOpen((o) => !o)}
                        src={null}
                      >
                        {nombre ? nombre[0] : ''}
                      </Avatar>
                    </motion.div>
                  </Menu.Target>
                  <Transition transition="pop" duration={200} mounted={userMenuOpen}>
                    {(styles) => (
                      <Menu.Dropdown style={styles} className="rounded-xl shadow-2xl border border-emerald-100 dark:border-emerald-900 bg-white/90 dark:bg-gray-900/90">
                        <Menu.Label className="text-emerald-700 dark:text-emerald-200 font-bold">¡Hola, {nombre}!</Menu.Label>
                        <Menu.Item leftSection={<IconUser size={18} />} component={Link} to="/perfil">
                          Mi perfil
                        </Menu.Item>
                        <Menu.Item leftSection={<IconSettings size={18} />} component={Link} to="/ajustes">
                          Ajustes
                        </Menu.Item>
                        <Menu.Divider />
                        <Menu.Item leftSection={<IconLogout size={18} />} color="red" onClick={handleLogout}>
                          Cerrar sesión
                        </Menu.Item>
                      </Menu.Dropdown>
                    )}
                  </Transition>
                </Menu>
              ) : (
                <motion.button
                  whileHover={{ scale: 1.08 }}
                  whileTap={{ scale: 1.15, y: -8, opacity: 0.8 }}
                  transition={{ type: 'spring', stiffness: 500, damping: 12 }}
                  onClick={() => setMostrarLoginModal(true)}
                  className="px-5 py-2 rounded-full font-bold bg-gradient-to-r from-emerald-500 to-emerald-700 text-white shadow-lg hover:shadow-emerald-200 flex items-center gap-2 text-lg transition-all duration-200"
                >
                  <IconLogin size={20} />
                  Iniciar sesión
                </motion.button>
              )}
            </div>
          </motion.div>
        </nav>
        {/* Menú móvil animado */}
        {/* The AnimatePresence block was removed as per the edit hint. */}
        {menuOpen && (
          <motion.nav
            initial={{ y: -40, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            exit={{ y: -40, opacity: 0 }}
            transition={{ duration: 0.25 }}
            className="fixed top-20 left-0 w-full bg-white/95 dark:bg-gray-900/95 shadow-2xl border-b border-emerald-100 dark:border-emerald-900 flex flex-col items-center gap-2 py-6 z-[200] backdrop-blur-xl"
          >
            {navLinks.map((link) => (
              <Link
                key={link.to}
                to={link.to}
                className="w-full text-center py-3 text-lg font-semibold text-emerald-800 dark:text-emerald-200 hover:bg-emerald-50 dark:hover:bg-emerald-900/40 transition-all duration-200 flex items-center justify-center gap-2"
                onClick={() => setMenuOpen(false)}
              >
                {link.icon}
                {link.label}
              </Link>
            ))}
            <div className="mt-4">
              {nombre ? (
                <button
                  onClick={handleLogout}
                  className="w-full px-5 py-2 rounded-full font-bold bg-gradient-to-r from-emerald-500 to-emerald-700 text-white shadow-lg hover:shadow-emerald-200 flex items-center gap-2 text-lg transition-all duration-200"
                >
                  <IconLogout size={20} />
                  Cerrar sesión
                </button>
              ) : (
                <button
                  onClick={() => {
                    setMostrarLoginModal(true);
                    setMenuOpen(false);
                  }}
                  className="w-full px-5 py-2 rounded-full font-bold bg-gradient-to-r from-emerald-500 to-emerald-700 text-white shadow-lg hover:shadow-emerald-200 flex items-center gap-2 text-lg transition-all duration-200"
                >
                  <IconLogin size={20} />
                  Iniciar sesión
                </button>
              )}
            </div>
          </motion.nav>
        )}
      </div>
      {/* Modales - FUERA del header */}
      {mostrarLoginModal && (
        <div className="fixed inset-0 z-[200]">
          <div
            className="absolute inset-0 backdrop-blur-md bg-black/10"
            onClick={() => setMostrarLoginModal(false)}
          ></div>
          <div className="absolute inset-0 flex items-center justify-center p-4">
            <div
              className="bg-white rounded-xl shadow-2xl max-w-md w-full border border-gray-200 relative z-10"
              onClick={(e) => e.stopPropagation()}
            >
              <LoginModal
                onClose={() => setMostrarLoginModal(false)}
                onOpenRegister={() => {
                  setMostrarLoginModal(false);
                  setMostrarRegisterModal(true);
                }}
              />
            </div>
          </div>
        </div>
      )}
      {mostrarRegisterModal && (
        <div className="fixed inset-0 z-[200]">
          <div
            className="absolute inset-0 backdrop-blur-md bg-black/10"
            onClick={() => setMostrarRegisterModal(false)}
          ></div>
          <div className="absolute inset-0 flex items-center justify-center p-4">
            <div
              className="bg-white rounded-xl shadow-2xl max-w-md w-full border border-gray-200 relative z-10"
              onClick={(e) => e.stopPropagation()}
            >
              <RegisterModal
                onClose={() => setMostrarRegisterModal(false)}
                onOpenLogin={() => {
                  setMostrarRegisterModal(false);
                  setMostrarLoginModal(true);
                }}
              />
            </div>
          </div>
        </div>
      )}
    </motion.header>
  );
}

export default Header;