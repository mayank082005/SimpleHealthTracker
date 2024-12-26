# SimpleHealthTracker

A Solidity smart contract to track personal health metrics securely on the blockchain. Users can log, retrieve, and manage their health data directly through the smart contract.

---

## Features

- **Add Health Metrics:** Users can add personal health records including weight, blood pressure, heart rate, blood sugar, and notes.
- **View Health Metrics:** Retrieve all stored health records or only the latest record.
- **Delete Health Metrics:** Remove the most recent health record.
- **Health Metric Count:** Get the total number of health records stored.

---

## Contract Overview

### Struct

```solidity
struct HealthMetric {
    uint256 timestamp;                 // Time of record creation
    uint256 weight;                    // Weight in kg
    uint256 bloodPressureSystolic;     // Systolic blood pressure
    uint256 bloodPressureDiastolic;    // Diastolic blood pressure
    uint256 heartRate;                 // Heart rate in beats per minute
    uint256 bloodSugar;                // Blood sugar level in mg/dL
    string  notes;                     // Optional notes
}
```

### Mappings

```solidity
mapping(address => HealthMetric[]) private healthRecords;
```
Stores the health records for each user address.

---

## Functions

### `addHealthMetric`

```solidity
function addHealthMetric(
    uint256 _weight,
    uint256 _systolic,
    uint256 _diastolic,
    uint256 _heartRate,
    uint256 _bloodSugar,
    string memory _notes
) public
```

- **Description:** Adds a new health record for the caller.
- **Validation:** Ensures inputs are within valid ranges.
- **Parameters:**
  - `_weight`: Weight in kg (1-500).
  - `_systolic`: Systolic blood pressure (1-300).
  - `_diastolic`: Diastolic blood pressure (1-200).
  - `_heartRate`: Heart rate (1-250).
  - `_bloodSugar`: Blood sugar level (1-1000).
  - `_notes`: Additional notes.
- **Emits:** `HealthMetricAdded` event.

### `getHealthMetrics`

```solidity
function getHealthMetrics() public view returns (HealthMetric[] memory)
```

- **Description:** Retrieves all health records for the caller.
- **Returns:** Array of `HealthMetric`.

### `getLatestHealthMetric`

```solidity
function getLatestHealthMetric() public view returns (HealthMetric memory)
```

- **Description:** Retrieves the most recent health record.
- **Returns:** `HealthMetric` object.
- **Reverts:** If no records are found.

### `deleteLatestHealthMetric`

```solidity
function deleteLatestHealthMetric() public
```

- **Description:** Deletes the most recent health record for the caller.
- **Emits:** `HealthMetricDeleted` event.
- **Reverts:** If no records exist.

### `getHealthMetricsCount`

```solidity
function getHealthMetricsCount() public view returns (uint256)
```

- **Description:** Returns the total number of health records for the caller.
- **Returns:** Count of health records.

---

## Events

### `HealthMetricAdded`

```solidity
event HealthMetricAdded(address indexed user, uint256 timestamp);
```
Emitted when a new health metric is added.

### `HealthMetricDeleted`

```solidity
event HealthMetricDeleted(address indexed user, uint256 timestamp);
```
Emitted when the most recent health metric is deleted.

---

## Deployment

### Prerequisites

1. Install [Remix IDE](https://remix.ethereum.org/) or set up a local Solidity development environment.
2. Ensure you have access to an Ethereum wallet (e.g., MetaMask) and testnet Ether.

### Steps

1. Copy the Solidity code from `SimpleHealthTracker.sol`.
2. Deploy the contract using Remix or a suitable development framework like Hardhat or Truffle.
3. Interact with the contract via Remix or a front-end connected to the blockchain.

---

## Example Usage

### Adding a Health Metric

```solidity
addHealthMetric(75, 120, 80, 72, 90, "Feeling great after workout");
```

### Retrieving All Health Metrics

```solidity
getHealthMetrics();
```

### Getting the Latest Health Metric

```solidity
getLatestHealthMetric();
```

### Deleting the Latest Health Metric

```solidity
deleteLatestHealthMetric();
```

### Getting the Count of Health Metrics

```solidity
getHealthMetricsCount();
```

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
