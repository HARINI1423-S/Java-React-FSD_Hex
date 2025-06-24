import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import AdminDashboard from "./components/admin/AdminDashboard";
import ViewUsers from "./components/admin/ViewUsers";
import AddUser from "./components/admin/AddUser";
import EditUser from "./components/admin/EditUser";
import DeleteUser from "./components/admin/DeleteUser";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Redirect "/" to "/admin" */}
        <Route path="/" element={<Navigate to="/admin" />} />

        <Route path="/admin" element={<AdminDashboard />}>
          <Route index element={<ViewUsers />} />
          <Route path="view" element={<ViewUsers />} />
          <Route path="add" element={<AddUser />} />
          <Route path="edit" element={<EditUser />} />
          <Route path="delete" element={<DeleteUser />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
