Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75238116DF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 12:07:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B55E21B02822;
	Thu,  2 May 2019 03:07:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EB1812122CA8A
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 03:07:43 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42A42dt055995;
 Thu, 2 May 2019 10:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=hUNB88HAMVczaNsSpZFezqMlqi202++OIGU7x2ByaDU=;
 b=1LhBzE7NxsQ+dndl0+IC/5w3UBpmKlkEYgGvh5ohEeN+HnrK4LxM7zhWWY1oLGL7nMio
 ovoKMS3XMAtmmBeuNvWbi7/m3/qMv8I0tC2mNMh1ChRkeLQ8xzjbFhXILTmqlxbocKEy
 n6Wv5S08kgpsNm3kUSJXfbJq1NSYwY7ca2S1FLp8TLowy+PkNzTClf3LTfkLPuiidK2E
 teZ9ks42nKvTWPT5ZF4KINDhNa6E+R1d+RlZaTM7oFSzpozohls7hNxhWJkmmluzcFgg
 Lom8ReTs5T5Vb3hGLBQn+x8ENhvLCABr5hD95Ofgybf9B+uV2ApaeupY5pTVL38iHbCh 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2s6xhyqhbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2019 10:07:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42A7eXf166533;
 Thu, 2 May 2019 10:07:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2s7p89p7xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2019 10:07:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x42A7bbW003685;
 Thu, 2 May 2019 10:07:37 GMT
Received: from mwanda (/196.97.155.240)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 02 May 2019 03:07:36 -0700
Date: Thu, 2 May 2019 13:07:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Subject: [bug report] acpi/nfit: Add support for Intel DSM 1.8 commands
Message-ID: <20190502100728.GA10650@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020075
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020075
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hello Dan Williams,

Commit 11189c1089da ("acpi/nfit: Fix command-supported detection") from
Jan 19, 2019 leads to the following static checker warning:

    drivers/acpi/nfit/core.c:503 acpi_nfit_ctl()
    error: passing untrusted data 'func' to 'variable_test_bit()'

Related but not critical:

    drivers/acpi/nfit/core.c:3510 acpi_nfit_clear_to_send()
    error: undefined (user controlled) shift '1 << func'

drivers/nvdimm/bus.c
  1062          buf = vmalloc(buf_len);
  1063          if (!buf)
  1064                  return -ENOMEM;
  1065  
  1066          if (copy_from_user(buf, p, buf_len)) {
  1067                  rc = -EFAULT;
  1068                  goto out;
  1069          }
  1070  
  1071          nvdimm_bus_lock(&nvdimm_bus->dev);
  1072          rc = nd_cmd_clear_to_send(nvdimm_bus, nvdimm, func, buf);
  1073          if (rc)
  1074                  goto out_unlock;
  1075  
  1076          rc = nd_desc->ndctl(nd_desc, nvdimm, cmd, buf, buf_len, &cmd_rc);
  1077          if (rc < 0)
  1078                  goto out_unlock;

This is __nd_ioctl().  We get "buf" from the user and then pass it to
acpi_nfit_clear_to_send() and then acpi_nfit_ctl().

drivers/acpi/nfit/core.c
   446  int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
   447                  unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
   448  {
   449          struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
   450          struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
   451          union acpi_object in_obj, in_buf, *out_obj;
   452          const struct nd_cmd_desc *desc = NULL;
   453          struct device *dev = acpi_desc->dev;
   454          struct nd_cmd_pkg *call_pkg = NULL;
   455          const char *cmd_name, *dimm_name;
   456          unsigned long cmd_mask, dsm_mask;
   457          u32 offset, fw_status = 0;
   458          acpi_handle handle;
   459          const guid_t *guid;
   460          int func, rc, i;
   461  
   462          if (cmd_rc)
   463                  *cmd_rc = -EINVAL;
   464  
   465          if (cmd == ND_CMD_CALL)
   466                  call_pkg = buf;
                        ^^^^^^^^^^^^^^

   467          func = cmd_to_func(nfit_mem, cmd, call_pkg);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We set func = call_pkg->nd_command (0-s32max).


   468          if (func < 0)
   469                  return func;
   470  
   471          if (nvdimm) {
   472                  struct acpi_device *adev = nfit_mem->adev;
   473  
   474                  if (!adev)
   475                          return -ENOTTY;
   476  
   477                  dimm_name = nvdimm_name(nvdimm);
   478                  cmd_name = nvdimm_cmd_name(cmd);
   479                  cmd_mask = nvdimm_cmd_mask(nvdimm);
   480                  dsm_mask = nfit_mem->dsm_mask;
   481                  desc = nd_cmd_dimm_desc(cmd);
   482                  guid = to_nfit_uuid(nfit_mem->family);
   483                  handle = adev->handle;
   484          } else {
   485                  struct acpi_device *adev = to_acpi_dev(acpi_desc);
   486  
   487                  cmd_name = nvdimm_bus_cmd_name(cmd);
   488                  cmd_mask = nd_desc->cmd_mask;
   489                  dsm_mask = nd_desc->bus_dsm_mask;
   490                  desc = nd_cmd_bus_desc(cmd);
   491                  guid = to_nfit_uuid(NFIT_DEV_BUS);
   492                  handle = adev->handle;
   493                  dimm_name = "bus";
   494          }
   495  
   496          if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
   497                  return -ENOTTY;
   498  
   499          /*
   500           * Check for a valid command.  For ND_CMD_CALL, we also have to
   501           * make sure that the DSM function is supported.
   502           */
   503          if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
                                                    ^^^^

"func" might be beyond the end of the bitmap so it could be an out of
bounds read.  We do bounds check it to <= 31 in nfit_dsm_revid() but I
couldn't see any range checking in acpi_evaluate_dsm().

   504                  return -ENOTTY;
   505          else if (!test_bit(cmd, &cmd_mask))
   506                  return -ENOTTY;
   507  
   508          in_obj.type = ACPI_TYPE_PACKAGE;
   509          in_obj.package.count = 1;
   510          in_obj.package.elements = &in_buf;
   511          in_buf.type = ACPI_TYPE_BUFFER;
   512          in_buf.buffer.pointer = buf;
   513          in_buf.buffer.length = 0;
   514  
   515          /* libnvdimm has already validated the input envelope */
   516          for (i = 0; i < desc->in_num; i++)
   517                  in_buf.buffer.length += nd_cmd_in_size(nvdimm, cmd, desc,
   518                                  i, buf);
   519  
   520          if (call_pkg) {
   521                  /* skip over package wrapper */
   522                  in_buf.buffer.pointer = (void *) &call_pkg->nd_payload;
   523                  in_buf.buffer.length = call_pkg->nd_size_in;
   524          }
   525  
   526          dev_dbg(dev, "%s cmd: %d: func: %d input length: %d\n",
   527                  dimm_name, cmd, func, in_buf.buffer.length);
   528          if (payload_dumpable(nvdimm, func))

[ snip ]

  3500  /* prevent security commands from being issued via ioctl */
  3501  static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
  3502                  struct nvdimm *nvdimm, unsigned int cmd, void *buf)
  3503  {
  3504          struct nd_cmd_pkg *call_pkg = buf;
  3505          unsigned int func;
  3506  
  3507          if (nvdimm && cmd == ND_CMD_CALL &&
  3508                          call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
  3509                  func = call_pkg->nd_command;
  3510                  if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
                             ^^^^^^^^^
This is undefined and it would be nice to fix, but not important for
run time.

  3511                          return -EOPNOTSUPP;
  3512          }
  3513  
  3514          return __acpi_nfit_clear_to_send(nd_desc, nvdimm, cmd);
  3515  }

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
