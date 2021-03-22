$(document).ready(function () {
    
    var value = ""
    var data
    
    hideBuilding()

    $('#customer_id').change(async function (event) {
        value = $(this).val()

        if (value === "") {
            hideBuilding()
        } else {

            $('#building_id').show()

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

            $('#battery_id').show()

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

            $('#column_id').show()

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

            $('#elevator_id').show()

            let elevators = [new Option("Select an elevator", "")]
            data = await getData(value, "elevator")

            data.forEach((element) => {elevators.push(new Option(`Elevator ID: ${element.id}`, element.id))})

            $('#elevator_id').html(elevators)

        }
    })

    function hideBuilding() {
        $('#building_id').hide()
        hideBattery()
    }

    function hideBattery() {
        $('#battery_id').hide()
        hideColumn()
    }

    function hideColumn() {
        $('#column_id').hide()
        hideElevator()
    }

    function hideElevator() {
        $('#elevator_id').hide()
    }

    async function getData(id, value) {
        const data = await $.ajax({
            type: "GET",
            url: `/ajax/GetData?id=${id}&value=${value}`,
        })
        return data
    }

})