const express = require('express');
const puppeteer = require('puppeteer');

const app = express();

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    next();
  }
});

app.get('/search', async (req, res) => {
  try {
    const { q } = req.query;
    const url = `https://www.google.com/search?q=${q}`;
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url, { waitUntil: 'networkidle0' });
    const results = await page.evaluate(() => {
        const elements = Array.from(document.querySelectorAll('div.g'));
        return elements.map(el => {
            const link = el.querySelector('a').href;
            const titleElement = el.querySelector('h3, h2');
            const title = titleElement ? titleElement.innerText : '';
            return { title, link };
        });
    });
    await browser.close();
    res.json(results);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
