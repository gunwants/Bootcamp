document.getElementById('weather-form').addEventListener('submit', function(e) {
    e.preventDefault(); // stop page reload
    const city = document.getElementById('city-input').value.trim();
    if (!city) return;

    const apiKey = '8c82ec964a294d025ecd0e993ebd4cb1'; 
    const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${encodeURIComponent(city)}&appid=${apiKey}&units=metric`;

    fetch(apiUrl)
        .then(response => {
            if (!response.ok) throw new Error('City not found');
            return response.json();
        })
        .then(data => {
            document.getElementById('weather-info').innerHTML = `
                <h2>${data.name}</h2>
                <p>${data.main.temp}°C, ${data.weather[0].description}</p>
            `;
        })
        .catch(err => {
            document.getElementById('weather-info').textContent = err.message;
        });
});