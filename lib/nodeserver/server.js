// const express = require('express');
// const path = require('path');
// const app = express();

// app.use(express.static(path.join(__dirname, '')));

// app.get('*', (req, res) => {
//     res.sendFile(path.join(__dirname, 'index.html'));
// });

// const PORT = process.env.PORT || 1212;
// app.listen(PORT, () => {
//     console.log(`Server is running on http://localhost:${PORT}`);
// });


const express = require('express');
const path = require('path');
const app = express();

// Serve static files from the current directory
app.use(express.static(path.join(__dirname, '')));

// Serve the index.html file for any route
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Listen on all available network interfaces (accept any IP)
const PORT = process.env.PORT || 1212;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on http://0.0.0.0:${PORT}`);
});
