<template>
  <section>
    <div class="modal-card" style="width: 62em; height: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">{{modalHeader}}</p>
      <button
          type="button"
          class="delete"
          @click="$emit('close')"/>
    </header>
    <section class="modal-card-body" ref="newOffice">
     
      <div class="box" >

        <div class="columns is-centered">
          <div class="column is-centered">

            <div class="columns">
              <div class="column">
                <b-field label="Nombre de dependencia" >
                  <b-input
                    v-model="aux_name_office"
                    placeholder="Ingrese el nombre de la dependencia o como se identifica"
                  ></b-input>
                </b-field>
              </div>
               <div class="column">
                <b-field label="Ubicación" >
                  <b-input
                    v-model="aux_location"
                    placeholder="Ingrese la ubicación de la dependencia (Edificio, en que piso se encuentra..)"
                  ></b-input>
                </b-field>
              </div>



            </div>
            <div class="columns">
                            <div class="column">
                <b-field label="N° Identificación" >
                  <b-input
                    v-model="aux_identification_number_office"
                    placeholder="Ingrese el numero de identificación de la dependencia"
                  ></b-input>
                </b-field>
              </div>
                            <div class="column">
                <b-field
                  label="Identificación administración campus"
                  
                >
                  <b-input
                    v-model="aux_campus_identification"
                    placeholder="Ingrese el numero de identificación de la dependencia"
                  ></b-input>
                </b-field>
              </div>

             


            </div>


            <div class="columns">

              <div class="column">
                <b-field label="Horas semanales disponibles" >
                  <b-numberinput
                    min="1"
                    max="100"
                    v-model="aux_hours_available"
                    type="is-info"
                    placeholder="Ingrese la cantidad de horas semanales disponibles de la dependencia"
                  >
                  </b-numberinput>
                </b-field>
              </div>

              <div class="column">
                <b-field label="Metros cuadrados" >
                  <b-numberinput
                    min="1"
                    max="100"
                    v-model="aux_square_meter"
                    type="is-info"
                    placeholder="Ingrese cuantos metro cuadrados tiene la dependencia"
                  >
                  </b-numberinput>
                </b-field>
              </div>

              
            </div>
               <div class="columns">
   
              <div class="column">
               

                <b-field label="Unidad" >
                  <multiselect
                    v-model="aux_unit_id"
                    :options="units.map((type) => type.id)"
                    :custom-label="
                      (opt) => units.find((x) => x.id === opt).name_unit
                    "
                    placeholder="Seleccionar Unidad"
                     selectLabel=""
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_duty_manager_id !== null || aux_building_id !== null "
                    @input="
                      getdutymanagerbyunit(aux_unit_id);
                      getbuildingbyunit(aux_unit_id);
                    "
                  >
                  </multiselect>
                </b-field>
              </div>

            </div>
            <div class="columns">
                            <div class="column">
                <b-field label="Edificio" >
                  <multiselect
                    v-model="aux_building_id"
                    :options="buildings.map((type) => type.id)"
                    :custom-label="
                      (opt) => buildings.find((x) => x.id === opt).name_building
                    "
                    placeholder="Seleccionar Unidad"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_unit_id == null"
                  >
                    
                  </multiselect>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Persona encargada" >
                  <multiselect
                    v-model="aux_duty_manager_id"
                    :options="managers.map((type) => type.id)"
                    :custom-label="
                      (opt) =>
                        managers.find((x) => x.id === opt).name_duty_manager
                    "
                    placeholder="Seleccionar Persona encargada"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_unit_id == null"
                  >
                  </multiselect>
                </b-field>
              </div>
            </div>
                        <div class="columns">

              <div class="column">
                <b-field label="Descripción de dependencia" >
                  <b-input
                    v-model="aux_office_description"
                    type="textarea"
                    placeholder="Ingrese la descripción de la dependencia, indicando cual es su uso"
                  ></b-input>
                </b-field>
              </div>


                        </div>


            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar dependencia"
                  type="is-info"
                  @click="confirmregister()"
                />
              </p>
            </b-field>
          </div>
        </div>
        </div>
    </section></div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name:"new_office",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      units: [],
      buildings: [],
      managers: [],
      offices: [],
      aux_name_office: null,
      aux_identification_number_office: null,
      aux_location: null,
      aux_office_description: null,
      aux_hours_available: null,
      aux_square_meter: null,
      aux_campus_identification: null,
      aux_duty_manager_id: null,
      aux_building_id: null,
      aux_unit_id: null,
    };
  },
  methods: {
    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managers = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async createClick() {
      const response = await axios.post("/offices.json", {
        name_office: this.aux_name_office,
        identification_number_office: this.aux_identification_number_office,
        location: this.aux_location,
        office_description: this.aux_office_description,
        hours_available: this.aux_hours_available,
        square_meter: this.aux_square_meter,
        campus_identification: this.aux_campus_identification,
        duty_manager_id: this.aux_duty_manager_id,
        building_id: this.aux_building_id,
      });
      window.location.href = "/offices";
    },
    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar Dependencia",
        message: `¿Esta seguro de registrar esta dependencia?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
  },
  created() {
    this.getunit();
  },
};
</script>