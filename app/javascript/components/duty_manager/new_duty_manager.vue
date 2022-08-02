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
    <section class="modal-card-body" ref="newDutyManager">
    
       <div class="box"> 
          <b-tabs> 
         <div class="columns is-centered">
        <div class="column is-centered">
 <div class="columns">
    <div class="column"> 
    <b-field label="Nombre" >
      <b-input v-model="aux_name_duty_manager" placeholder="Ingrese el nombre del personal"></b-input>
    </b-field>
    </div>
 </div>
 <div class="columns">
     <div class="column">

    <b-field label="Rut" >
      <b-input v-model="aux_rut" placeholder="Ingrese el RUT de la persona asociada sin puntos y con guion"></b-input>
    </b-field>
     </div>
     </div>
      <div class="columns">
      <div class="column">
    <b-field label="Unidad" >
      <multiselect
      v-model="aux_unit_id"
      :options="units.map((type) => type.id)"
      :custom-label="(opt) => units.find((x) => x.id === opt).name_unit"
      placeholder="Seleccionar Unidad"
       selectLabel=""
      selectedLabel="Seleccionado"
      deselectLabel=""
      :allow-empty="false"
      >
      </multiselect>
    </b-field>
      </div>
 </div>

    <b-field grouped position="is-right" >
      <p class="control">
        <b-button label="Agregar Persona asociada" type="is-info" @click="confirmregister()" />
      </p>
    </b-field>
        </div></div>
         </b-tabs>
       </div>
    
    </section>
      </div>
  </section>
</template>

<script>
import axios from "axios";
export default {
    name:"new_duty_manager",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      managers: [],
      units: [],
      aux_name_duty_manager: null,
      aux_rut: null,
      aux_unit_id: null,
    };
  },
  methods: {
    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
      console.log(this.units);
    },
    
    async createClick() {
      const response = await axios.post("/duty_managers.json", {
        name_duty_manager: this.aux_name_duty_manager,
        rut: this.aux_rut,
        unit_id: this.aux_unit_id,
      });
      console.log(this.aux_unit_id);
      window.location.href = "/duty_managers";
    },
                    confirmregister() {
                this.$buefy.dialog.confirm({
                    title: 'Registra Persona asociada',
                    message: `¿Esta seguro de registrar a la persona asociada?`,
                    cancelText: 'Cancelar',
                    confirmText: 'Registrar',
                    type: 'is-info',
                    onConfirm: () => this.createClick()
                })
            },
  },
  created() {
    this.getunit();
  },
};
</script>