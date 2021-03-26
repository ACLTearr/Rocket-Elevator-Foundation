$(document).ready(function () {
    
    var value = ""
    var data
    
    hideBuilding()

    $('#customer_id').change(async function (event) {
        value = $(this).val()
        if (value === "") {
            hideBuilding()
        } else {
            $('#building').show()
            let buildings = [new Option("Select a building", "")]
            data = await getData(value, "building")
            data.forEach((element) => {buildings.push(new Option(`${element.full_name_of_the_technical_contact_for_the_building}, Building ID: ${element.id}`, element.id));})
            $('#building_id').html(buildings)
        }
    })

    $('#building_id').change(async function (event) {
        value = $(this).val()
        if (value === "") {
            hideBattery()
        } else {
            $('#battery').show()
            let batteries = [new Option("Select a battery", "")]
            data = await getData(value, "battery")
            data.forEach((element) => {batteries.push(new Option(`Battery ID: ${element.id}`, element.id))})
            $('#battery_id').html(batteries)
        }
    })

    $('#battery_id').change(async function (event) {
        value = $(this).val()
        if (value === "") {
            hideColumn()
        } else {
            $('#column').show()
            let columns = [new Option("Select a column", "")]
            data = await getData(value, "column")
            data.forEach((element) => {columns.push(new Option(`Column ID: ${element.id}`, element.id))})
            $('#column_id').html(columns)
        }
    })

    $('#column_id').change(async function (event) {
        value = $(this).val()
        if (value === "") {
            hideElevator()
        } else {
            $('#elevator').show()
            let elevators = [new Option("Select an elevator", "")]
            data = await getData(value, "elevator")
            data.forEach((element) => {elevators.push(new Option(`Elevator ID: ${element.id}`, element.id))})
            $('#elevator_id').html(elevators)
        }
    })

    function hideBuilding() {
        $('#building').hide()
        hideBattery()
    }

    function hideBattery() {
        $('#battery').hide()
        hideColumn()
    }

    function hideColumn() {
        $('#column').hide()
        hideElevator()
    }

    function hideElevator() {
        $('#elevator').hide()
    }

    async function getData(id, value) {
        const data = await $.ajax({
            type: "GET",
            url: `/ajax/GetData?id=${id}&value=${value}`,
        })
        return data
    }
})