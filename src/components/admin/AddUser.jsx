import axios from "axios";
import { useState } from "react";

function AddUser() {
    let [name, setName] = useState("");
    let [email, setEmail] = useState("");
    let [gender, setGender] = useState("male");
    let [status, setStatus] = useState("active");
    let [msg, setMsg] = useState("");
    let [error, setError] = useState("");

    const addUser = async () => {
        if (name.trim() === "" || email.trim() === "" || gender === "" || status === "") {
            setError("All fields are required");
            setMsg("");
            return;
        }

        try {
            await axios.post("https://gorest.co.in/public/v2/users",
                {
                    name: name,
                    email: email,
                    gender: gender,
                    status: status
                },
                {
                    headers: {
                        Authorization: 'Bearer 782fd255354ff382512df635344e13a2c4af0bddf27034219f9345b0bfbb1115'
                    }
                }
            );
            setMsg("User added successfully");
            setError("");
        } catch (err) {
            setError("Failed to add user. Try again.");
            setMsg("");
        }
    }

    return (
        <div className="container mt-4">
            <h3>Add User</h3>

            {error !== "" && <div className="alert alert-danger">{error}</div>}
            {msg !== "" && <div className="alert alert-success">{msg}</div>}

            <div className="mb-3">
                <label>Name</label>
                <input
                    type="text"
                    value={name}
                    onChange={e => setName(e.target.value)}
                    className="form-control"
                />
            </div>

            <div className="mb-3">
                <label>Email</label>
                <input
                    type="email"
                    value={email}
                    onChange={e => setEmail(e.target.value)}
                    className="form-control"
                />
            </div>

            <div className="mb-3">
                <label>Gender</label>
                <select
                    className="form-control"
                    value={gender}
                    onChange={e => setGender(e.target.value)}
                >
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
            </div>

            <div className="mb-3">
                <label>Status</label>
                <select
                    className="form-control"
                    value={status}
                    onChange={e => setStatus(e.target.value)}
                >
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>
            </div>

            <div className="mb-3">
                <button className="btn btn-success" onClick={addUser}>Add User</button>
            </div>
        </div>
    );
}

export default AddUser;
