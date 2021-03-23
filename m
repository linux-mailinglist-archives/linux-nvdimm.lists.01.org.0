Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34534600B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 14:47:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B5E1100EBBB9;
	Tue, 23 Mar 2021 06:47:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DFD1A100EC1F5
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 06:47:33 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NDYKjm191958;
	Tue, 23 Mar 2021 09:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=dS5PYmVbk3H/ors98/PXLwF9D17DN5thsm8ab7PkYIA=;
 b=FBRU6anTuicw3oZAUHSgNc+5qc91L047GScwsU3bzgrvLr/Zw+as/5lhNmaQXyzfF1tc
 v6Bm1CzCORfRYlla2OtOuRP4hXUTOFxRtRKr+RIdQ3plX1M7OyG7fczsIt5wTX8B03HV
 ffiAzUnlWdUpy6rRsy7kutBIQ9F5Gu17HwZF+KZE0pbLZubswO+mf+Q/IELPTB+v4+HO
 zh/oB5LayXMhp7EJhQdmfZLhFToyTY9Cvy7MStJEq9yfT4U9QZqUqmYX4xkR4iXPxwRj
 BHerhNMKi6RgEmDMF+88/zdDvH6EX/gOez/9x2jEsn1dtmrW1NN2AyWMCW4XChZlJU70 CQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjwuxsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 09:47:19 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NDYlBp195919;
	Tue, 23 Mar 2021 09:47:18 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjwuxry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 09:47:18 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NDlFlf031034;
	Tue, 23 Mar 2021 13:47:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03fra.de.ibm.com with ESMTP id 37d9bpss17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 13:47:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NDkuAn35782988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Mar 2021 13:46:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93B742042;
	Tue, 23 Mar 2021 13:47:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A914203F;
	Tue, 23 Mar 2021 13:47:11 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.40.192.207])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 23 Mar 2021 13:47:11 +0000 (GMT)
Subject: [PATCH v3 0/3] spapr: nvdimm: Enable sync-dax property for nvdimm
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: sbhat@linux.vnet.ibm.com, david@gibson.dropbear.id.au, groug@kaod.org,
        qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
        mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Date: Tue, 23 Mar 2021 09:47:10 -0400
Message-ID: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230100
Message-ID-Hash: L3NVMVAZXGMMKB5DMP4YOFAKCNU7LU3X
X-Message-ID-Hash: L3NVMVAZXGMMKB5DMP4YOFAKCNU7LU3X
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L3NVMVAZXGMMKB5DMP4YOFAKCNU7LU3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nvdimm devices are expected to ensure write persistence during power
failure kind of scenarios.

The libpmem has architecture specific instructions like dcbf on power
to flush the cache data to backend nvdimm device during normal writes.

Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
doesn't traslate to actual flush to the backend file on the host in case
of file backed v-nvdimms. This is addressed by virtio-pmem in case of x86_64
by making explicit flushes translating to fdatasync at qemu.

On PAPR, the issue is addressed by adding a new hcall to
request for an explicit flush from the guest ndctl driver when the backend
nvdimm cannot ensure write persistence with dcbf alone. So, the approach
here is to convey when the hcall flush is required in a device tree
property. The guest makes the hcall when the property is found, instead
of relying on dcbf.

The first patch adds the necessary asynchronous hcall support infrastructure
code at the DRC level. Second patch implements the hcall using the
infrastructure.

Hcall number and semantics finalized, so dropping the RFC prefix.

A new device property sync-dax is added to the nvdimm device. When the 
sync-dax is off(default), device property "hcall-flush-required" is set,
and the guest makes hcall H_SCM_FLUSH requesting for an explicit flush. 

By default, sync-dax is "off" on all new pseries machines and prior to
5.2 its "on",

The below demonstration shows the map_sync behavior with sync-dax on & off.
(https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c)

The pmem0 is from nvdimm with With sync-dax=on, and pmem1 is from nvdimm with syn-dax=off, mounted as
/dev/pmem0 on /mnt1 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
/dev/pmem1 on /mnt2 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)

[root@atest-guest ~]# ./mapsync /mnt1/newfile    ----> When sync-dax=off
[root@atest-guest ~]# ./mapsync /mnt2/newfile    ----> when sync-dax=on
Failed to mmap  with Operation not supported

The first patch does the header file cleanup necessary for the
subsequent ones. Second patch implements the hcall, adds the necessary
vmstate properties to spapr machine structure for carrying the hcall
status during save-restore. The nature of the hcall being asynchronus,
the patch uses aio utilities to offload the flush. The third patch adds
the 'sync-dax' device property and enables the device tree property
for the guest to utilise the hcall.

---
v2 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg07031.html
Changes from v2:
      - Using the thread pool based approach as suggested by Greg
      - Moved the async hcall handling code to spapr_nvdimm.c along
        with some simplifications
      - Added vmstate to preserve the hcall status during save-restore
        along with pre_save handler code to complete all ongoning flushes.
      - Added hw_compat magic for sync-dax 'on' on previous machines.
      - Miscellanious minor fixes.

v1 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg06330.html
Changes from v1
      - Fixed a missed-out unlock
      - using QLIST_FOREACH instead of QLIST_FOREACH_SAFE while generating token

Shivaprasad G Bhat (3):
      spapr: nvdimm: Forward declare and move the definitions
      spapr: nvdimm: Impletment scm flush hcall
      spapr: nvdimm: Enable sync-dax device property for nvdimm


 hw/core/machine.c             |    1 
 hw/mem/nvdimm.c               |    1 
 hw/ppc/spapr.c                |    6 +
 hw/ppc/spapr_nvdimm.c         |  269 +++++++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h       |   10 ++
 include/hw/ppc/spapr.h        |   12 ++
 include/hw/ppc/spapr_nvdimm.h |   34 +++--
 7 files changed, 317 insertions(+), 16 deletions(-)

--
Signature


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
