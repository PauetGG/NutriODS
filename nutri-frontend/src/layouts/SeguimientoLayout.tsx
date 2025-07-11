import { Outlet } from "react-router-dom";
import { Sidebar } from "../components/SideBar";

function SeguimientoLayout() {


  return (
    <div className="flex">
      <Sidebar />
      <div className="flex-1 p-4">
        <Outlet />
      </div>
    </div>
  );
}

export default SeguimientoLayout;
