-- Everlake: the in-game Store is free. Every product costs 0 shop points, so nobody needs points (or real money) to use it.
-- Also takes the 100 Gold, Level 60 and Max Alchemy products out. Professions held only Max Alchemy, so its group goes too
-- (the Store sends every group, even an empty one).
DELETE FROM `shop_product_action` WHERE `ProductID` IN (2,14,20);
DELETE FROM `shop_product` WHERE `ID` IN (2,14,20);
DELETE FROM `shop_group` WHERE `ID` = 3;
UPDATE `shop_product` SET `Price` = 0, `NormalPrice` = 0;
