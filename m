Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767B2AEFA1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 12:30:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 583EC167416AB;
	Wed, 11 Nov 2020 03:30:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8550B167416A8
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 03:30:12 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABBTvU2141921;
	Wed, 11 Nov 2020 11:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=g4MSiwdfP5ikHmPs/Oc4530jBG5JfCXE+gSEtaWwu1o=;
 b=HnxG4L1BWXXS7Zt+IVdghcZ4DRgA2igSEVR+rqsdJkfSG/Opy9dpJP4J/+6nxw8Xc57z
 wv74Cjw4NP/DMzifainRNlI8lZHUGyEusuheQ58UDz4QVtfwxjJ+RgaF1WlCLwKB01BH
 p07rLAA7rKVh3Q2xILVjffH5OSTAL2cphpPeiG92gJUZaqPfUQM88cJm35lV219q1x7B
 uDGIEkUcwWtnGM5lMKC9TOHC5cm8EuCEHi+KMg/SXdGMUCA6SCQvxhTGP/SyDY9Eh7LM
 rrVZhVru2jwdMMydivgyciIzXkhLif3SLc3pH8rg/vAcY5iS7pVJW/0NZPW1xYLuw5Gu yA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 34nkhm0du8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Nov 2020 11:30:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABBKtmp096785;
	Wed, 11 Nov 2020 11:30:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 34p5g1kvp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2020 11:30:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ABBU69a032013;
	Wed, 11 Nov 2020 11:30:06 GMT
Received: from mwanda (/41.57.98.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 11 Nov 2020 03:30:05 -0800
Date: Wed, 11 Nov 2020 14:30:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: dan.j.williams@intel.com
Subject: [bug report] ACPI: NFIT: Define runtime firmware activation commands
Message-ID: <20201111113000.GA1237157@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=3 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110066
Message-ID-Hash: UMW52LPXEK5E3SQ52U6IIXWKLTXUILYY
X-Message-ID-Hash: UMW52LPXEK5E3SQ52U6IIXWKLTXUILYY
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMW52LPXEK5E3SQ52U6IIXWKLTXUILYY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dan Williams,

The patch 6450ddbd5d8e: "ACPI: NFIT: Define runtime firmware
activation commands" from Jul 20, 2020, leads to the following static
checker warning:

    drivers/acpi/nfit/core.c:481 acpi_nfit_ctl()
    error: passing untrusted data 'family' to 'test_bit()'

    drivers/acpi/nfit/core.c:483 acpi_nfit_ctl()
    warn: uncapped user index 'acpi_desc->family_dsm_mask[family]'

drivers/acpi/nfit/core.c
   435  int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
   436                  unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
   437  {
   438          struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
   439          struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
   440          union acpi_object in_obj, in_buf, *out_obj;
   441          const struct nd_cmd_desc *desc = NULL;
   442          struct device *dev = acpi_desc->dev;
   443          struct nd_cmd_pkg *call_pkg = NULL;
   444          const char *cmd_name, *dimm_name;
   445          unsigned long cmd_mask, dsm_mask;
   446          u32 offset, fw_status = 0;
   447          acpi_handle handle;
   448          const guid_t *guid;
   449          int func, rc, i;
   450          int family = 0;
   451  
   452          if (cmd_rc)
   453                  *cmd_rc = -EINVAL;
   454  
   455          if (cmd == ND_CMD_CALL)
   456                  call_pkg = buf;
                        ^^^^^^^^^^^^^^^
If cmd == ND_CMD_CALL then call_pkg is controlled by the user.

   457          func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);

cmd_to_func() checks "call_pkg->nd_family" but only if nfit_mem is
non-NULL.

   458          if (func < 0)
   459                  return func;
   460  
   461          if (nvdimm) {
   462                  struct acpi_device *adev = nfit_mem->adev;
   463  
   464                  if (!adev)
   465                          return -ENOTTY;
   466  
   467                  dimm_name = nvdimm_name(nvdimm);
   468                  cmd_name = nvdimm_cmd_name(cmd);
   469                  cmd_mask = nvdimm_cmd_mask(nvdimm);
   470                  dsm_mask = nfit_mem->dsm_mask;
   471                  desc = nd_cmd_dimm_desc(cmd);
   472                  guid = to_nfit_uuid(nfit_mem->family);
   473                  handle = adev->handle;
   474          } else {
   475                  struct acpi_device *adev = to_acpi_dev(acpi_desc);
   476  
   477                  cmd_name = nvdimm_bus_cmd_name(cmd);
   478                  cmd_mask = nd_desc->cmd_mask;
   479                  if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
   480                          family = call_pkg->nd_family;
   481                          if (!test_bit(family, &nd_desc->bus_family_mask))
                                              ^^^^^^
if "family" is more BITS_PER_LONG then this will overflow.

   482                                  return -EINVAL;
   483                          dsm_mask = acpi_desc->family_dsm_mask[family];
                                                      ^^^^^^^^^^^^^^^^^^^^^^^

   484                          guid = to_nfit_bus_uuid(family);
   485                  } else {
   486                          dsm_mask = acpi_desc->bus_dsm_mask;
   487                          guid = to_nfit_uuid(NFIT_DEV_BUS);
   488                  }
   489                  desc = nd_cmd_bus_desc(cmd);
   490                  handle = adev->handle;
   491                  dimm_name = "bus";
   492          }
   493  
   494          if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
   495                  return -ENOTTY;
   496  
   497          /*
   498           * Check for a valid command.  For ND_CMD_CALL, we also have to
   499           * make sure that the DSM function is supported.
   500           */
   501          if (cmd == ND_CMD_CALL &&

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
