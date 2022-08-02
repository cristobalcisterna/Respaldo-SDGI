<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
      <h1>Edificios de la facultad</h1>
      <b-tabs>
        <b-tab-item>  
                     <div class="has-text-right">
              <b-button
                label="Añadir edificio"
                type="is-info"
                icon-left="plus"
                @click="createBuilding()"
              ></b-button>
            </div> 
            <div> 
                  <b-modal
          :active="isModalActive"
          aria-modal
          has-modal-card
          :destroy-on-hide="true"
          aria-role="dialog"
          width="100%"
          :can-cancel="canCancel">
        <template>
          <new-building modal-cancel="true"
                            :modal-header="'Registro de Edificio'"
                            query-type="create"
                            @close="closeModalCreate"></new-building>
        </template>
      </b-modal>



      </div>

          <div class="column">
            <b-table 
            :data="buildings"
            :paginated=true 
                per-page="8"
                striped
                hoverable
                :pagination-simple=false
                pagination-position="bottom"
                default-sort-direction="asc" 
                sort-icon="arrow-up"
                sort-icon-size="is-small"
                default-sort="inventores.name"
                aria-next-label="Siguiente"
                aria-previous-label="Anterior"
                aria-page-label="Página"
                aria-current-label="Página actual">
              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              <b-table-column
                field="name_building"
                label="Nombre Edificio"
                sortable
                searchable
              >

                <template v-slot="props">
                   <a href="#" @click="Clickshowbuilding(props.row.id)">{{ props.row.name_building }}</a>

                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_building"
                label="N° Identificación"
                sortable
                searchable
              >
                <template v-slot="props">
                  {{ props.row.identification_number_building }}
                </template>
              </b-table-column>

              <b-table-column
                field="duty_manager.name_duty_manager"
                label="Nombre Persona encargada"
                sortable
                searchable
              >
                <template v-slot="props">
                 <a href="#" @click="Clickshowdutymanager(props.row.duty_manager_id)">{{ props.row.duty_manager.name_duty_manager }}</a>
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
           
              <b-table-column field="id" width="10"  v-slot="props">
              <b-tooltip label="Ver detalle" type="is-info">
                         <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowbuilding(props.row.id)"/>
              </b-tooltip>
              </b-table-column>

            </b-table>
          </div>
        </b-tab-item>
      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import NewBuilding from './new_building.vue';
import ShowBuilding from './show_building.vue';
export default {
  data() { 
    return {
      buildings: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },
    components:{
    NewBuilding,
        ShowBuilding},
  methods: {
    async getbuilding() {
      const response = await axios.get("http://localhost:3000/buildings.json");
      this.buildings = response.data;
    },
        async Clicknewbuilding() {
      const response = (window.location.href = "/buildings/new");
    },
        async Clickshowbuilding(item) {
      const response = (window.location.href = "/buildings/" + item );
    },
     async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item );
    },
       async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    async createBuilding(){
      this.isModalActive = true;
    },
    async closeModalCreate(){
      this.isModalActive = false;
    },
        async ShowModaleBuilding(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },


  },
  created() {
    this.getbuilding();
  },
};
</script>


