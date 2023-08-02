// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductRegistry {
    // Struct to store product information
    struct Product {
        string productName;
        address owner;
        bool isGenuine;
    }

    // Mapping to store products using product IDs
    mapping(uint256 => Product) public products;
    // Address of the contract owner
    address public owner;

    // Event emitted when a product is registered
    event ProductRegistered(uint256 indexed productId, string productName, address indexed owner);
    // Event emitted when a product is verified
    event ProductVerified(uint256 indexed productId, bool isGenuine);

    // Modifier to restrict certain actions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to register a new product
    function registerProduct(uint256 productId, string memory productName) external {
        require(products[productId].owner == address(0), "Product ID already registered");

        // Create a new Product struct and store it in the mapping
        products[productId] = Product(productName, msg.sender, false);
        
        // Emit a ProductRegistered event
        emit ProductRegistered(productId, productName, msg.sender);
    }

    // Function to verify a product's authenticity
    function verifyProduct(uint256 productId) external onlyOwner {
        require(products[productId].owner != address(0), "Product ID not registered");

        // Mark the product as genuine
        products[productId].isGenuine = true;

        // Emit a ProductVerified event
        emit ProductVerified(productId, true);
    }
}
