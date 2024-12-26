// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SimpleHealthTracker
 * @dev A smart contract to track personal health metrics
 */
contract SimpleHealthTracker {
    // Struct to store health metrics
    struct HealthMetric {
        uint256 timestamp;
        uint256 weight;        // in kg
        uint256 bloodPressureSystolic;
        uint256 bloodPressureDiastolic;
        uint256 heartRate;     // beats per minute
        uint256 bloodSugar;    // mg/dL
        string  notes;
    }

    // Mapping to store user health records
    mapping(address => HealthMetric[]) private healthRecords;

    // Events to log health metric additions
    event HealthMetricAdded(address indexed user, uint256 timestamp);
    event HealthMetricDeleted(address indexed user, uint256 timestamp);

    /**
     * @dev Add a new health metric record
     * @param _weight Weight in kg
     * @param _systolic Systolic blood pressure
     * @param _diastolic Diastolic blood pressure
     * @param _heartRate Heart rate in beats per minute
     * @param _bloodSugar Blood sugar level in mg/dL
     * @param _notes Optional notes about the health metric
     */
    function addHealthMetric(
        uint256 _weight,
        uint256 _systolic,
        uint256 _diastolic,
        uint256 _heartRate,
        uint256 _bloodSugar,
        string memory _notes
    ) public {
        // Validate input ranges
        require(_weight > 0 && _weight < 500, "Invalid weight");
        require(_systolic > 0 && _systolic < 300, "Invalid systolic pressure");
        require(_diastolic > 0 && _diastolic < 200, "Invalid diastolic pressure");
        require(_heartRate > 0 && _heartRate < 250, "Invalid heart rate");
        require(_bloodSugar > 0 && _bloodSugar < 1000, "Invalid blood sugar");

        // Create new health metric
        HealthMetric memory newMetric = HealthMetric({
            timestamp: block.timestamp,
            weight: _weight,
            bloodPressureSystolic: _systolic,
            bloodPressureDiastolic: _diastolic,
            heartRate: _heartRate,
            bloodSugar: _bloodSugar,
            notes: _notes
        });

        // Add to user's health records
        healthRecords[msg.sender].push(newMetric);

        // Emit event
        emit HealthMetricAdded(msg.sender, block.timestamp);
    }

    /**
     * @dev Get all health metrics for the caller
     * @return Array of health metrics
     */
    function getHealthMetrics() public view returns (HealthMetric[] memory) {
        return healthRecords[msg.sender];
    }

    /**
     * @dev Get the most recent health metric
     * @return Most recent health metric
     */
    function getLatestHealthMetric() public view returns (HealthMetric memory) {
        HealthMetric[] storage userRecords = healthRecords[msg.sender];
        require(userRecords.length > 0, "No health metrics found");
        return userRecords[userRecords.length - 1];
    }

    /**
     * @dev Delete the most recent health metric
     */
    function deleteLatestHealthMetric() public {
        HealthMetric[] storage userRecords = healthRecords[msg.sender];
        require(userRecords.length > 0, "No health metrics to delete");
        
        // Remove the last record
        userRecords.pop();

        // Emit event
        emit HealthMetricDeleted(msg.sender, block.timestamp);
    }

    /**
     * @dev Get the total number of health metrics for the caller
     * @return Number of health metrics
     */
    function getHealthMetricsCount() public view returns (uint256) {
        return healthRecords[msg.sender].length;
    }
}