## Part 2: Identify the business process

Now that you’ve set up the dbt project, database, and have taken a peek at the schema, it’s time for you to identify the business process. 

Identifying the business process is done in collaboration with the business user. The business user has context around the business objectives and business processes, and can provide you with that information. 

![](img/conversation.png)

*Conversation between business user and analytics engineer*

Upon speaking with the CEO of AdventureWorks, you learn the following information: 

<blockquote>
AdventureWorks manufactures bicycles and sells them to consumers (B2C) and businesses (B2B). The bicycles are shipped to customers from all around the world. As the CEO of the business, I would like to know how much revenue we have generated for the year ending 2011, broken down by: 

- Product category and subcategory 
- Customer 
- Order status 
- Shipping country, state, and city
</blockquote>

Based on the information provided by the business user, you have identified that the business process in question is the ***Sales process***. In the next part, you are going to design a dimensional model for the Sales process. 

[&laquo; Previous](part01-setup-dbt-project.md) [Next &raquo;](part03-identify-fact-dimension.md)
