﻿using System.Linq;
using Dimensional.TinyReturns.Core;
using Xunit;

namespace Dimensional.TinyReturns.IntegrationTests.Core.DataRepository
{
    public class EntityDataRepositoryTests : DatabaseTestBase
    {
        [Fact]
        public void GetAllEntitiesShouldReturnCorrectNumberOfEntities()
        {
            var entityDataRepository = MasterFactory.GetEntityDataRepository();

            var results = entityDataRepository.GetAllEntities();

            Assert.Equal(results.Length, 5);
        }

        [Fact]
        public void GetAllEntitiesShouldReturnMapAllColumnsToProperties()
        {
            var entityDataRepository = MasterFactory.GetEntityDataRepository();

            var results = entityDataRepository.GetAllEntities();

            var target = results.FirstOrDefault(r => r.EntityNumber == 100);

            Assert.NotNull(target);

            Assert.Equal(target.EntityTypeCode, "P");
            Assert.Equal(target.Name, "Portfolio 100 - Large");
        }
    }
}