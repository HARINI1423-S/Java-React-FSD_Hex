import axios from "axios";
import { useState } from "react";

function DeleteUser() {
    let [id, setId] = useState("");
    let [msg, setMsg] = useState("");

    const deleteUser = async () => {
        let confirmDelete = window.confirm(`Are you sure you want to delete user ID ${id}?`);
        if (!confirmDelete) return;

        try {
            await axios.delete(`https://gorest.co.in/public/v2/users/${id}`, {
                headers: {
                    Authorization: 'Bearer 782fd255354ff382512df635344e13a2c4af0bddf27034219f9345b0bfbb1115'
                }
            });
            setMsg("User deleted successfully");
        } catch (err) {
            setMsg("Failed to delete user");
        }
    };

    return (
        <div className="container mt-4">
            <h3>Delete User</h3>
            {msg !== "" && <div className="alert alert-danger">{msg}</div>}
            <div className="mb-3">
                <label>Enter User ID to delete</label>
                <input type="text" onChange={e => setId(e.target.value)} className="form-control" />
            </div>
            <div className="mb-3">
                <button className="btn btn-danger" onClick={deleteUser}>Delete User</button>
            </div>
        </div>
    );
}

export default DeleteUser;
