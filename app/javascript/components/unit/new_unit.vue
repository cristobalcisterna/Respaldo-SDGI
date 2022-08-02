<template>
  <section>

 <div class="modal-card" style="width: 45em; height: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">{{modalHeader}}</p>
      <button
          type="button"
          class="delete"
          @click="$emit('close')"/>
    </header>
    <section class="modal-card-body" ref="newUnit">
      <div class="box" >
        <b-tabs>
        <div class="columns is-centered">
          <div class="column is-centered ">
            <div class="columns">
              <div class="column">
                <b-field label="Nombre de Unidad" >
                  <b-input
                    v-model="aux_name_unit"
                    placeholder="Ingrese el nombre de la unidad"
                  ></b-input>
                </b-field>
              </div>
            </div>
            <div class="columns">
              <div class="column">
                <b-field label="Descripción" >
                  <b-input
                    v-model="aux_description_unit"
                    placeholder="Ingrese la descripción de la unidad"
                  ></b-input>
                </b-field>
              </div>
              </div>
              <div class="columns">
              <div class="column">
                <b-field label="N° Identificación" >
                  <b-input
                    v-model="aux_identification_number_unit"
                    placeholder="Ingrese el numero de identificación de la unidad"
                  ></b-input>
                </b-field>
              </div>
            </div>

            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar Unidad"
                  type="is-info"
                  @click="confirmregister()"
                />
              </p>
            </b-field>
          </div>
        </div></b-tabs> </div
    >
    </section>
 </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name:"new_unit",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      units: [],
      aux_name_unit: null,
      aux_description_unit: null,
      aux_identification_number_unit: null,
    };
  },
  methods: {
    async createClick() {
      const response = await axios.post("/units.json", {
        name_unit: this.aux_name_unit,
        description_unit: this.aux_description_unit,
        identification_number_unit: this.aux_identification_number_unit,
      });
      window.location.href = "/units";
    },

    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar Unidad",
        message: `¿Esta seguro de registrar esta unidad?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
    },
  },
};
</script>