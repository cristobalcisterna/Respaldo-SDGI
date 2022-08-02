<template>
  <section>
     <div class="modal-card" style="width: 50em; height: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">{{modalHeader}}</p>
      <button
          type="button"
          class="delete"
          @click="$emit('close')"/>
    </header>
    <section class="modal-card-body" ref="newBuilding">




    <div class="box">
      <b-tabs> 
        <div class="columns is-centered">
          <div class="column is-centered">
            <div class="columns">
              <div class="column">
                <b-field label="Nombre de edificio">
                  <b-input
                    v-model="aux_name_building"
                    placeholder="Ingrese el nombre del edificio"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="N° Identificación">
                  <b-input
                    v-model="aux_identification_number_building"
                    placeholder="Ingrese el numero de identificación del edificio"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Ubicación">
                  <b-input
                    v-model="aux_location_building"
                    placeholder="Ingrese la ubicacion del edificio (En que sector se encuentra)"
                  ></b-input>
                </b-field>
              </div>
            </div>

            <div class="columns">
              <div class="column">
                <b-field label="Unidad">
                  <multiselect
                    v-model="aux_unit_id"
                    :options="units.map((type) => type.id)"
                    :custom-label="
                      (opt) => units.find((x) => x.id === opt).name_unit
                    "
                    placeholder="Seleccionar Unidad"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    :allow-empty="true"
                    :disabled="aux_duty_manager_id !== null"
                    @input="getdutymanagerbyunit(aux_unit_id)"
                  >
                  </multiselect>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Persona asociada encargada ">
                  <multiselect
                    v-model="aux_duty_manager_id"
                    :options="managersaux.map((type) => type.id)"
                    :custom-label="
                      (opt) =>
                        managersaux.find((x) => x.id === opt).name_duty_manager
                    "
                    placeholder="Seleccionar persona asociada encargada"
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

            <b-field grouped position="is-right">
              <p class="control">
                <b-button
                  label="Agregar Edificio"
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
  name:"new_building",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      buildings: [],
      managers: [],
      managersaux: [],
      units: [],
      aux_name_building: null,
      aux_identification_number_building: null,
      aux_location_building: null,
      aux_unit_id: null,
      aux_duty_manager_id: null,
    };
  },
  methods: {
    async getdutymanager() {
      const response = await axios.get(
        "http://localhost:3000/duty_managers.json"
      );
      this.managers = response.data;
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managersaux = response.data;
    },

    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
    },
    async createClick() {
      const response = await axios.post("/buildings.json", {
        name_building: this.aux_name_building,
        identification_number_building: this.aux_identification_number_building,
        location_building: this.aux_location_building,
        unit_id: this.aux_unit_id,
        duty_manager_id: this.aux_duty_manager_id,
      });
      window.location.href = "/buildings";
    },
    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar Edificio",
        message: `¿Esta seguro de registrar esté edificio?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
  },
  created() {
    this.getdutymanager();
    this.getunit();
  },
};
</script>