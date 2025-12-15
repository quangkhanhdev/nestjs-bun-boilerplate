import {Body, Controller, Delete, Get, Param, Patch, Post} from '@nestjs/common'
import {CreateUserDto} from './dto/create-user.dto'
import {UpdateUserDto} from './dto/update-user.dto'
import {UserService} from './user.service'

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get()
  findAll() {
    return this.userService.findAll()
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.userService.findOne(+id)
  }

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.userService.create(createUserDto)
  }

  @Patch(':id')
  updateOne(@Body() updateUserDto: UpdateUserDto, @Param('id') id: string) {
    return this.userService.update(+id, updateUserDto)
  }

  @Delete(':id')
  removeOne(@Param('id') id: string) {
    return this.userService.remove(+id)
  }
}
