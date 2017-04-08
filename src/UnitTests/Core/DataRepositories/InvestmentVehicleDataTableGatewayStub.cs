﻿using System;
using System.Collections.Generic;
using Dimensional.TinyReturns.Core.TinyReturnsDatabase;

namespace Dimensional.TinyReturns.UnitTests.Core
{
    public class InvestmentVehicleDataTableGatewayStub : IInvestmentVehicleDataTableGateway
    {
        private readonly EntityDtoCollectionForTest _entityDtoCollectionForTest;

        public InvestmentVehicleDataTableGatewayStub()
        {
            _entityDtoCollectionForTest = new EntityDtoCollectionForTest();
        }

        public void SetupGetAllEntities(
            Action<EntityDtoCollectionForTest> a)
        {
            a(_entityDtoCollectionForTest);
        }
        
        public InvestmentVehicleDto[] GetAllEntities()
        {
            return _entityDtoCollectionForTest.GetEntities();
        }

        public class EntityDtoCollectionForTest
        {
            private readonly List<InvestmentVehicleDto> _entities;

            public EntityDtoCollectionForTest()
            {
                _entities = new List<InvestmentVehicleDto>();
            }

            public EntityDtoCollectionForTest AddPortfolio(
                int number,
                string name)
            {
                _entities.Add(InvestmentVehicleDto.CreateForPortfolio(number, name));

                return this;
            }

            public EntityDtoCollectionForTest AddPortfolio(
                InvestmentVehicleDto investmentVehicle)
            {
                _entities.Add(investmentVehicle);

                return this;
            }

            public InvestmentVehicleDto[] GetEntities()
            {
                return _entities.ToArray();
            }
        }
    }
}