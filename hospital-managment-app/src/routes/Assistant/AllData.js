import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './AllData.css'; // Importer le fichier CSS


function AllData() {
  const [allData, setAllData] = useState([]);

  useEffect(() => {
    const fetchAllData = async () => {
      try {
        const response = await axios.get('http://localhost:5000/alldata');
        setAllData(response.data.filter(patient => patient.valid === 0)); // Filter patients with valid === 0
      } catch (error) {
        console.error('Error fetching all data:', error);
      }
    };

    fetchAllData();
  }, []);





  return (
    <div className='table' id='seepa'>
      <h2>Patients</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Prénom</th>
            <th>Nom</th>
            <th>Email</th>
            <th>CIN</th>
            <th>Gender</th>
            <th>service</th>
          </tr>
        </thead>
        <tbody>
          {allData.map((patient) => (
            <tr key={patient._id}>
              <td>{patient._id}</td>
              <td>{patient.prenom}</td>
              <td>{patient.nom}</td>
              <td>{patient.Email}</td>
              <td>{patient.CIN}</td>
              <td>{patient.Gender}</td>
              <td>{patient.Service}</td>


            </tr>
          ))}
        </tbody>
      </table>
    
    </div>
  );
}

export default AllData;
