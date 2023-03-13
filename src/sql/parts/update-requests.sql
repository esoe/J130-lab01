USE merchent;
UPDATE requests
    SET
        requests.delivery = "2023-02-25",
        requests.position = 'S'
    WHERE requests.id = 6;