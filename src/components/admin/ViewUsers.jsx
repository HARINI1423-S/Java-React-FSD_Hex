import axios from "axios";
import { useEffect, useState } from "react";

function ViewUsers() {
    let [users, setUsers] = useState([]);
    let [msg, setMsg] = useState("");

    useEffect(() => {
        const getAllUsers = async () => {
            try {
                let response = await axios.get("https://gorest.co.in/public/v2/users");
                setUsers(response.data);
            } catch (err) {
                setMsg("Could not fetch users");
            }
        }
        getAllUsers();
    }, []);

    return (
        <div className="container mt-4">
            <h3>All Users</h3>
            {msg !== "" && <div className="alert alert-danger">{msg}</div>}
            <table className="table table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Gender</th><th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        users.map((u) => (
                            <tr key={u.id}>
                                <td>{u.name}</td>
                                <td>{u.email}</td>
                                <td>{u.gender}</td>
                                <td>{u.status}</td>
                            </tr>
                        ))
                    }
                </tbody>
            </table>
        </div>
    )
}

export default ViewUsers;
