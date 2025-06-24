import axios from "axios";
import { useState } from "react";

function EditUser() {
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [gender, setGender] = useState("male");
  const [status, setStatus] = useState("active");
  const [msg, setMsg] = useState("");

  const token = "Bearer 782fd255354ff382512df635344e13a2c4af0bddf27034219f9345b0bfbb1115";

  const fetchUserDetails = async () => {
    if (!id) {
      setMsg("Please enter a user ID.");
      return;
    }

    try {
      const res = await axios.get(`https://gorest.co.in/public/v2/users/${id}`, {
        headers: {
          Authorization: token,
        },
      });

      // Fill form fields
      setName(res.data.name || "");
      setEmail(res.data.email || "");
      setGender(res.data.gender || "male");
      setStatus(res.data.status || "active");
      setMsg("User fetched successfully.");
    } catch (err) {
      setMsg("❌ Failed to fetch user details.");
      setName("");
      setEmail("");
      setGender("male");
      setStatus("active");
    }
  };

  const updateUser = async () => {
    if (!name || !email) {
      setMsg("Name and Email are required.");
      return;
    }

    try {
      await axios.put(
        `https://gorest.co.in/public/v2/users/${id}`,
        { name, email, gender, status },
        {
          headers: {
            Authorization: token,
          },
        }
      );
      setMsg("✅ User updated successfully.");
    } catch (err) {
      setMsg("❌ Failed to update user.");
    }
  };

  return (
    <div className="container mt-4">
      <h3>Edit User</h3>
      {msg && <div className="alert alert-info">{msg}</div>}

      <div className="mb-3">
        <label>User ID</label>
        <input
          type="text"
          className="form-control"
          value={id}
          onChange={(e) => setId(e.target.value)}
        />
        <button className="btn btn-dark mt-2" onClick={fetchUserDetails}>
          Fetch User
        </button>
      </div>

      <div className="mb-3">
        <label>Name</label>
        <input
          type="text"
          className="form-control"
          value={name || ""}
          onChange={(e) => setName(e.target.value)}
        />
      </div>

      <div className="mb-3">
        <label>Email</label>
        <input
          type="email"
          className="form-control"
          value={email || ""}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>

      <div className="mb-3">
        <label>Gender</label>
        <select
          className="form-control"
          value={gender || "male"}
          onChange={(e) => setGender(e.target.value)}
        >
          <option value="male">Male</option>
          <option value="female">Female</option>
        </select>
      </div>

      <div className="mb-3">
        <label>Status</label>
        <select
          className="form-control"
          value={status || "active"}
          onChange={(e) => setStatus(e.target.value)}
        >
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
      </div>

      <div className="mb-3">
        <button className="btn btn-warning" onClick={updateUser}>
          Update User
        </button>
      </div>
    </div>
  );
}

export default EditUser;
