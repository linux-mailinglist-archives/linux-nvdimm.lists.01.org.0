Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9EC13A327
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jan 2020 09:43:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9501D10097E0A;
	Tue, 14 Jan 2020 00:46:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F23DE10097DF6
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 00:46:27 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E8h4qf037205;
	Tue, 14 Jan 2020 08:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=6e/W9TQHg2xePSimcFP2Q3jO4cc4W9D6PWex2C6fsU4=;
 b=QBggGLZ2dhJzcmsoH2/qO79QuzRdqaLO0X67jUtBcsLiQ6+nFHKe/lq6kxRACIxTrnjj
 4wMbzVgFbBpgShZP7J43Hdn1f/OqgcJe41abgKn5nk1yxRLnX4k9jasKmv61mMbNfF+a
 zXX7GJs+60itiq4N1weg7UBRFy+lLVB9eMQIIAYQa95ic6a+TBCS6Po2i1yiucWY8eL9
 IozcQI8In/uQNkwF4h34+c6lZCT+aX5BYKlgvjOPFdACG6hK2oGQDz2vUfyMz9XSKG8E
 HwHnz2QEG0oqcixcHLoIugrHyqLStXTI1f/9YM0xDGRePd3YVCIFsPJc+8GyA2TYuvpk rQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 2xf73tmarc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2020 08:43:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E8d7WV143109;
	Tue, 14 Jan 2020 08:41:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 2xh8ernms0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2020 08:41:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E8f12N008342;
	Tue, 14 Jan 2020 08:41:01 GMT
Received: from kadam (/129.205.23.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 14 Jan 2020 00:41:00 -0800
Date: Tue, 14 Jan 2020 11:40:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: syzbot <syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com>,
        dave.jiang@intel.com, dan.j.williams@intel.com
Subject: Re: KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl
Message-ID: <20200114084051.GB3719@kadam>
References: <0000000000009acfef059c13c771@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0000000000009acfef059c13c771@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140077
Message-ID-Hash: 3KHWYY3MWKLGQI56RFRX2NWJXQAPFKAM
X-Message-ID-Hash: 3KHWYY3MWKLGQI56RFRX2NWJXQAPFKAM
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3KHWYY3MWKLGQI56RFRX2NWJXQAPFKAM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2020 at 10:34:10PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    040a3c33 Merge tag 'iommu-fixes-v5.5-rc5' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=120a5d8ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
> dashboard link: https://syzkaller.appspot.com/bug?extid=002f559bf34c2c7467d0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: vmalloc-out-of-bounds in test_bit
> include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x47f/0x1840
> drivers/acpi/nfit/core.c:495
> Read of size 8 at addr ffffc90002ddbbb8 by task syz-executor.1/5941
> 
> CPU: 3 PID: 5941 Comm: syz-executor.1 Not tainted 5.5.0-rc5-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
>  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:639
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
>  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
>  acpi_nfit_ctl+0x47f/0x1840 drivers/acpi/nfit/core.c:495
>  __nd_ioctl drivers/nvdimm/bus.c:1152 [inline]
>  nd_ioctl.isra.0+0xfe2/0x1580 drivers/nvdimm/bus.c:1230

drivers/acpi/nfit/core.c
   438  int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
   439                  unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
                                          ^^^^^^^^^
"buf" comes from the user.

   440  {
   441          struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
   442          struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
   443          union acpi_object in_obj, in_buf, *out_obj;
   444          const struct nd_cmd_desc *desc = NULL;
   445          struct device *dev = acpi_desc->dev;
   446          struct nd_cmd_pkg *call_pkg = NULL;
   447          const char *cmd_name, *dimm_name;
   448          unsigned long cmd_mask, dsm_mask;
   449          u32 offset, fw_status = 0;
   450          acpi_handle handle;
   451          const guid_t *guid;
   452          int func, rc, i;
   453  
   454          if (cmd_rc)
   455                  *cmd_rc = -EINVAL;
   456  
   457          if (cmd == ND_CMD_CALL)
   458                  call_pkg = buf;
                        ^^^^^^^^^^^^^^
   459          func = cmd_to_func(nfit_mem, cmd, call_pkg);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
func is call_pkg->nd_command so it comes from the user.

   460          if (func < 0)
   461                  return func;
   462  
   463          if (nvdimm) {
   464                  struct acpi_device *adev = nfit_mem->adev;
   465  
   466                  if (!adev)
   467                          return -ENOTTY;
   468  
   469                  dimm_name = nvdimm_name(nvdimm);
   470                  cmd_name = nvdimm_cmd_name(cmd);
   471                  cmd_mask = nvdimm_cmd_mask(nvdimm);
   472                  dsm_mask = nfit_mem->dsm_mask;
   473                  desc = nd_cmd_dimm_desc(cmd);
   474                  guid = to_nfit_uuid(nfit_mem->family);
   475                  handle = adev->handle;
   476          } else {
   477                  struct acpi_device *adev = to_acpi_dev(acpi_desc);
   478  
   479                  cmd_name = nvdimm_bus_cmd_name(cmd);
   480                  cmd_mask = nd_desc->cmd_mask;
   481                  dsm_mask = nd_desc->bus_dsm_mask;
   482                  desc = nd_cmd_bus_desc(cmd);
   483                  guid = to_nfit_uuid(NFIT_DEV_BUS);
   484                  handle = adev->handle;
   485                  dimm_name = "bus";
   486          }
   487  
   488          if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
   489                  return -ENOTTY;
   490  
   491          /*
   492           * Check for a valid command.  For ND_CMD_CALL, we also have to
   493           * make sure that the DSM function is supported.
   494           */
   495          if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
                                                    ^^^^
If func is more than sizeof(long) * 8 then this will overflow.  The
temptation is to add a check on func in cmd_to_func() but capping it at
sizeof(long) * 8 feels unnatural and I'm not sure what the max function
should be.

[Edit.  I see below that > 31 is not supported. ]

   496                  return -ENOTTY;
   497          else if (!test_bit(cmd, &cmd_mask))
   498                  return -ENOTTY;
   499  
   500          in_obj.type = ACPI_TYPE_PACKAGE;
   501          in_obj.package.count = 1;
   502          in_obj.package.elements = &in_buf;

There is a another problem in acpi_nfit_clear_to_send().

acpi/nfit/core.c
  3485  /* prevent security commands from being issued via ioctl */
  3486  static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
  3487                  struct nvdimm *nvdimm, unsigned int cmd, void *buf)
  3488  {
  3489          struct nd_cmd_pkg *call_pkg = buf;
  3490          unsigned int func;
  3491  
  3492          if (nvdimm && cmd == ND_CMD_CALL &&
  3493                          call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
  3494                  func = call_pkg->nd_command;
  3495                  if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
                             ^^^^^^^^^
This is undefined if func is greater than 31.

  3496                          return -EOPNOTSUPP;
  3497          }
  3498  
  3499          return __acpi_nfit_clear_to_send(nd_desc, nvdimm, cmd);
  3500  }

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
