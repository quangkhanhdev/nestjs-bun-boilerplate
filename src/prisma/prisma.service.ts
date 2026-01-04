import {Injectable, OnModuleDestroy, OnModuleInit} from '@nestjs/common'
import {PrismaPg} from '@prisma/adapter-pg'
import {PrismaClient} from '@prisma/client'
import {Pool} from 'pg'

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleDestroy, OnModuleInit {
  constructor() {
    const pool = new Pool({connectionString: process.env.DATABASE_URL})
    const adapter = new PrismaPg(pool)
    super({
      adapter,
      log: ['query', 'info', 'warn', 'error'],
    })
  }

  async onModuleInit() {
    console.log({DB_URL: process.env.DATABASE_URL})
    await this.$connect()
  }

  async onModuleDestroy() {
    await this.$disconnect()
  }
}
