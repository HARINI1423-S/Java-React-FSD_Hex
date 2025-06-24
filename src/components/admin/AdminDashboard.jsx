import { Link, Outlet } from "react-router-dom";

function AdminDashboard() {
  return (
    <div className="container mt-5">
      <h2 className="text-center mb-4 fw-bold text-uppercase text-secondary">
        Admin Dashboard - User Management
      </h2>

      <div className="d-flex justify-content-center gap-3 flex-wrap mb-5">
        <Link to="view" className="btn btn-outline-primary px-4">
          👁️ View Users
        </Link>
        <Link to="add" className="btn btn-outline-success px-4">
          ➕ Add User
        </Link>
        <Link to="edit" className="btn btn-outline-warning px-4">
          ✏️ Edit User
        </Link>
        <Link to="delete" className="btn btn-outline-danger px-4">
          🗑️ Delete User
        </Link>
      </div>

      <div className="d-flex justify-content-center">
        <div className="shadow p-4 rounded bg-light w-100" style={{ maxWidth: "600px" }}>
          <Outlet />
        </div>
      </div>
    </div>
  );
}

export default AdminDashboard;
