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
    <section class="modal-card-body" ref="newGood">


    <div class="box">
      <b-tabs>
        <div class="columns is-centered">
          <div class="column is-centered">
            <div class="columns">
              
              <div class="column">
                <b-field label="Nombre">
                  <b-input
                    v-model="aux_namegood"
                    placeholder="Ingrese el nombre del bien"
                  ></b-input>
                </b-field>
              </div>

              <div class="column">
                <b-field label="Marca">
                  <b-input
                    v-model="aux_trademark"
                    placeholder="Ingrese la marca o el modelo del bien"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Numero inventario usach">
                  <b-input
                    v-model="aux_identification_number_usach"
                    placeholder="Ingrese el numero inventario usach del bien"
                  ></b-input>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Numero inventario">
                  <b-input
                    v-model="aux_identification_number_good"
                    placeholder="Ingrese el numero inventario del bien"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Numero de serie">
                  <b-input
                    v-model="aux_serie_number"
                    placeholder="Ingrese el numero de serie del bien"
                  ></b-input>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Numero interno">
                  <b-input
                    v-model="aux_internal_number"
                    placeholder="Ingrese el numero interno del bien"
                  ></b-input>
                </b-field>
              </div>
            </div>
           
            <div class="columns">
              <div class="column">
                <b-field label="Ubicación">
                  <b-input
                    v-model="aux_location_good"
                    placeholder="Ingrese la ubicación del bien (Edificio, oficina, en que piso se encuentra..)"
                  ></b-input>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Fecha de asignación">
                  <b-datepicker
                    v-model="aux_date_release"
                    locale="es-ES"
                    placeholder="Seleccionar fecha de asignación"
                    trap-focus
                  >
                  </b-datepicker>
                </b-field>
              </div>
            </div>

                      <div class="columns">
              <div class="column">
                <b-field label="Monto Bruto">
                   <b-numberinput
                    min="0"
                    v-model="aux_amount"
                    type="is-info"
                    placeholder="Ingrese el monto bruto del bien"
                  >
                  </b-numberinput>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Fecha de Compra">
                  <b-datepicker
                    v-model="aux_date_purchase"
                    locale="es-ES"
                    placeholder="Seleccionar fecha de compra"
                    trap-focus
                  >
                  </b-datepicker>
                </b-field>
              </div>
            </div>

                        <div class="columns">
              <div class="column">
                <b-field label="Fuente de Financiamiento">
                  <multiselect
                    style="is-info"
                    v-model="aux_financial_source_id"
                    :options="financial_sources.map((type) => type.id)"
                    :custom-label="
                      (opt) => financial_sources.find((x) => x.id === opt).name_financial_source
                    "
                    placeholder="Seleccionar fuente de financiamiento"
                    selectLabel=""
                    selectLabelcolor=""
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"></multiselect>
                </b-field>
              </div>



              <div class="column">
                <b-field label="Tipo de inversión">
                  <multiselect
                    style="is-info"
                    v-model="aux_investment_type_id"
                    :options="investment_types.map((type) => type.id)"
                    :custom-label="
                      (opt) => investment_types.find((x) => x.id === opt).name_investment_type"
                    placeholder="Seleccionar Tipo de inversión"
                    selectLabel=""
                    selectLabelcolor=""
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"></multiselect>
                </b-field>
              </div>
            </div>








            <div class="columns">
              <div class="column">
                <b-field label="Unidad">
                  <multiselect
                    style="is-info"
                    v-model="aux_unit_id"
                    :options="units.map((type) => type.id)"
                    :custom-label="
                      (opt) => units.find((x) => x.id === opt).name_unit
                    "
                    placeholder="Seleccionar Unidad"
                    selectLabel=""
                    selectLabelcolor=""
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="
                      aux_duty_manager_id !== null || aux_building_id !== null
                    "
                    @input="
                      getdutymanagerbyunit(aux_unit_id);
                      getbuildingbyunit(aux_unit_id);
                    "
                  >
                  </multiselect>
                </b-field>
              </div>

              <div class="column">
                <b-field label="Persona asociada encargada">
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
                <b-field label="Edificio">
                  <multiselect
                    v-model="aux_building_id"
                    :options="buildings.map((type) => type.id)"
                    :custom-label="
                      (opt) => buildings.find((x) => x.id === opt).name_building
                    "
                    placeholder="Seleccionar"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_unit_id == null || aux_office_id !== null"
                    @input="getofficebybuilding(aux_building_id)"
                  >
                  </multiselect>
                </b-field>
              </div>

              <div class="column">
                <b-field label="Dependencia">
                  <multiselect
                    v-model="aux_office_id"
                    :options="offices.map((type) => type.id)"
                    :custom-label="
                      (opt) => offices.find((x) => x.id === opt).name_office
                    "
                    placeholder="Seleccionar dependencia"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_building_id == null"
                  >
                  </multiselect>
                </b-field>
              </div>
            </div>
             <div class="columns">
              
              <div class="column">
                <b-field label="Descripción">
                  <b-input
                    v-model="aux_good_description"
                    placeholder="Ingrese una descripción del bien o el nombre"
                    type="textarea"
                  ></b-input>
                </b-field>
              </div>
            </div>

            <b-field grouped position="is-right">
              <p class="control">
                <b-button
                  label="Agregar Bien"
                  type="is-info"
                  @click="confirmregister()"
                />
              </p>
            </b-field>
          </div>
        </div>
      </b-tabs>
    </div>
    </section>
    </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name:"new_good",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      goods: [],
      offices: [],
      units: [],
      financial_sources: [],
      investment_types: [],
      managers: [],
      buildings: [],
      dropFiles: [],
      aux_namegood: null,
      aux_good_description: null,
      aux_identification_number_usach: null,
      aux_identification_number_good: null,
      aux_serie_number: null,
      aux_internal_number: null,
      aux_trademark: null,
      aux_location_good: null,
      aux_date_release: new Date(),
      aux_duty_manager_id: null,
      aux_office_id: null,
      aux_unit_id: null,
      aux_building_id: null,
      aux_financial_source_id: null,
      aux_investment_type_id: null,
      aux_amount: null,
      aux_date_purchase: new Date(),
      aux_financial_source: null,
      aux_investment_type: null,
      aux_activegood: 1,
    };
  },
  methods: {
    async getgoods() {
      const response = await axios.get("http://localhost:3000/goods.json");
      this.goods = response.data;
    },

    async getfinancialsource() {
      const response = await axios.get("http://localhost:3000/financial_sources.json");
      this.financial_sources = response.data;
      console.log(this.financial_sources);
    },

        async getinvestmenttype() {
      const response = await axios.get("http://localhost:3000/investment_types.json");
      this.investment_types = response.data;
      console.log(this.investment_types);
    },




        async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
      console.log(this.units);
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managers = response.data;
      console.log(this.managers);
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
      console.log(this.buildings);
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
      console.log(this.offices);
    },

    async createClick() {
      const response = await axios.post("/goods.json", {

        namegood:this.aux_namegood,
        good_description: this.aux_good_description,
        identification_number_usach: this.aux_identification_number_usach,
        identification_number_good: this.aux_identification_number_good,
        serie_number: this.aux_serie_number,
        internal_number: this.aux_internal_number,
        trademark: this.aux_trademark,
        location_good: this.aux_location_good,
        date_release: this.aux_date_release,
        duty_manager_id: this.aux_duty_manager_id,
        office_id: this.aux_office_id,
        activegood: this.aux_activegood,
        amount: this.aux_amount,
        date_purchase: this.aux_date_purchase,
        financial_source_id: this.aux_financial_source_id,
        investment_type_id: this.aux_investment_type_id,
      });
      window.location.href = "/goods";
    },
    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar el Bien",
        message: `¿Esta seguro de registrar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
    deleteDropFile(index) {
                this.dropFiles.splice(index, 1)
            },
  },
  created() {
    this.getgoods();
    this.getunit();
    this.getfinancialsource();
    this.getinvestmenttype();
    
  },
};
</script>