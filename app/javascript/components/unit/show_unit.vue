<template>
  <section class="b-tooltips">
    <div 
      class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
     <h1>Detalle de la Unidad</h1>
      <b-tabs type="is-boxed" position="is-centered">
        <b-tab-item label="Detalle de la Unidad">
           <div class="center"> <h1>Información de la Unidad</h1></div>
          <div class="box" >
 
          <div v-if="unit" class="columns is-centered">
            <div class="column is-centered">

              <div class="columns"> 
                <div class="column">
                  <b-field label="Nombre la unidad:">
                       <b-input
                    v-model=" unit.name_unit " type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

              <div class="columns">
                <div class="column">
                  <b-field label="Numero identificación de la unidad:">
                   <b-input
                    v-model="unit.identification_number_unit" type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

              <div class="columns"> 
              <div class="column">
                <b-field label="Monto bruto total invertido en bienes: ">
                  <b-input
                    v-model="total" type="text" readonly
                  ></b-input>
                </b-field>
              </div>
            </div>

              <div class="columns">
                <div class="column">
                  <b-field label="Descripción:">
                       <b-input
                    v-model="unit.description_unit" type="text" readonly></b-input>
                  </b-field>
                </div>
              </div>

            </div>
          </div>

          <div v-else>
            <p>Loading</p>
          </div>
          </div>
        </b-tab-item>

        <b-tab-item label="Personas asociadas a la unidad">
           <div class="center"> <h1>Personas asociadas a la facultad</h1></div>
          <div class="box">
            <div class="column">
              <b-table
                :data="managers"
                :paginated="true"
                per-page="8"
                striped
                hoverable
                :pagination-simple="false"
                pagination-position="bottom"
                default-sort-direction="asc"
                sort-icon="arrow-up"
                sort-icon-size="is-small"
                default-sort="inventores.name"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual"
              >
                <b-table-column
                  :visible="false"
                  field="id"
                  label="ID"
                  sortable
                  searchable
                >

                  <template v-slot="props">
                    {{ props.row.id }}
                  </template>
                </b-table-column>

                <b-table-column
                  field="name_duty_manager"
                  label="Nombre de la persona asociada"
                  sortable
                  searchable
                >

                  <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.id)">{{ props.row.name_duty_manager }}</a>
                  </template>
                </b-table-column>

                <b-table-column field="rut" label="Rut" sortable searchable>

                  <template v-slot="props">
                    {{ props.row.rut }}
                  </template>
                </b-table-column>

                <b-table-column
                  field="unit.name_unit"
                  label="Nombre Unidad"
                  sortable
                  searchable
                >

                  <template v-slot="props">
                    <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>
            
                  </template>
                </b-table-column>

                <b-table-column field="id" width="10" v-slot="props">
                 <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowdutymanager(props.row.id)"/>
              </b-tooltip>
                </b-table-column>
              </b-table>
            </div>
          </div>
        </b-tab-item>
      </b-tabs>
    </div>
    <a href="/units"   style= "font-weight: normal;
  font-size: 20px;
  font-family: Arial;
  margin: 10px;
  margin-left: 30px;">Volver</a>
  </section>
</template>


<script>
import axios from "axios";
export default {
  name:"show_unit",
  props: ["id",'queryType', 'modalHeader','unitId'],
  data() {
    return {
      total: null,
      unit: null,
      managers: [],
      goods: [],
      goodamounts: [],
      props: ["id"],
    };
  },
  methods: {
    async getunits() {
      const response = await axios.get("/units/" + this.unitId + ".json");
      this.unit = response.data;
    },

    async getdutymanagerbyunit() {
      const response = await axios.get(
        "/duty_managers/showdutymanagerunit/" + this.unitId + ".json"
      );
      this.managers = response.data;
    },
    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },

            async getgoodbyunit() {
      const response = await axios.get("/goods/showgoodunit/" + this.unitId + ".json");
      this.goods = response.data;
      this.goodamounts = this.goods.map(o => o['amount']);

      const c = 0;
      this.total = this.goodamounts.reduce((a, b) => a + b,c);

      console.log(this.goods);
      console.log(this.goodamounts);
      console.log(this.total);
   
    },
  },
  created() {
    this.getunits();
    this.getdutymanagerbyunit();
    this.getgoodbyunit();
  },
};
</script>

