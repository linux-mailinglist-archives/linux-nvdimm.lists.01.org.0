Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E722C8781
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Nov 2020 16:16:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74712100EC1F2;
	Mon, 30 Nov 2020 07:16:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A446100EC1EC
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 07:16:26 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUEmxq8134051;
	Mon, 30 Nov 2020 10:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=SVunJp4tA4QxqyyebemWUkhMQjF3mk9I7QKpQCzCIYw=;
 b=r/QIno9Xo/xO4H+mXfvE/3pHss07Yvz1UKLT38kW7GQsKEgWLm+SV1H5V13dcMRWS/4j
 7dcqKJ9YY8N3nr5A4Mb1l1gDM544ki/1AEl6QvejV5upE1PKjcAJh2VUcfTnq+XgXwnV
 IGfAEn71H0pI7+oXsW0iaELAQ1Lav6H7WhJ4WtnalD06161VTybOnIEQmQo7lrhezJKO
 9N8k7UPzleTiUy+RLzVngePah2opW8Zg102Yy7EJ5sEyJtBMIxZHP6Oxco+WXkAjXwo7
 EVBEvTGuAJ1ZwSl7Tr/XZhyHt7oLG7qmjEMD0a6FpKf0VeqPY8+Qik0gwjRFyyQF+vYo /g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3552u5ryrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:16:22 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AUEplk5146991;
	Mon, 30 Nov 2020 10:16:21 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3552u5ryq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:16:21 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUF94mW008196;
	Mon, 30 Nov 2020 15:16:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03ams.nl.ibm.com with ESMTP id 353e68a5p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 15:16:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUFGHwt62914990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Nov 2020 15:16:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF27AAE045;
	Mon, 30 Nov 2020 15:16:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45D6BAE051;
	Mon, 30 Nov 2020 15:16:15 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 30 Nov 2020 15:16:15 +0000 (GMT)
Subject: [RFC Qemu PATCH v2 0/2] spapr: nvdimm: Asynchronus flush hcall
 support
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com,
        david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org
Date: Mon, 30 Nov 2020 09:16:14 -0600
Message-ID: 
 <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_05:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300094
Message-ID-Hash: GJHCD5F2WWENNQH6P26CH5QWEUEMNGC4
X-Message-ID-Hash: GJHCD5F2WWENNQH6P26CH5QWEUEMNGC4
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, aneesh.kumar@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OT6JJ7QW7RBKJYOFR7RHA7MEBNIFPAC2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nvdimm devices are expected to ensure write persistent during power
failure kind of scenarios.

The libpmem has architecture specific instructions like dcbf on power
to flush the cache data to backend nvdimm device during normal writes.

Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
doesn't traslate to actual flush to the backend file on the host in case
of file backed vnvdimms. This is addressed by virtio-pmem in case of x86_64
by making asynchronous flushes.

On PAPR, issue is addressed by adding a new hcall to
request for an explicit asynchronous flush requests from the guest ndctl
driver when the backend nvdimm cannot ensure write persistence with dcbf
alone. So, the approach here is to convey when the asynchronous flush is
required in a device tree property. The guest makes the hcall when the
property is found, instead of relying on dcbf.

The first patch adds the necessary asynchronous hcall support infrastructure
code at the DRC level. Second patch implements the hcall using the
infrastructure.

Hcall semantics are in review and not final.

A new device property sync-dax is added to the nvdimm device. When the 
sync-dax is off(default), the asynchronous hcalls will be called.

With respect to save from new qemu to restore on old qemu, having the
sync-dax by default off(when not specified) causes IO errors in guests as
the async-hcall would not be supported on old qemu. The new hcall
implementation being supported only on the new  pseries machine version,
the current machine version checks may be sufficient to prevent
such migration. Please suggest what should be done.

The below demonstration shows the map_sync behavior with sync-dax on & off.
(https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c)

The pmem0 is from nvdimm with With sync-dax=on, and pmem1 is from nvdimm with syn-dax=off, mounted as
/dev/pmem0 on /mnt1 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
/dev/pmem1 on /mnt2 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)

[root@atest-guest ~]# ./mapsync /mnt1/newfile    ----> When sync-dax=off
[root@atest-guest ~]# ./mapsync /mnt2/newfile    ----> when sync-dax=on
Failed to mmap  with Operation not supported

---
v1 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg06330.html
Changes from v1
      - Fixed a missed-out unlock
      - using QLIST_FOREACH instead of QLIST_FOREACH_SAFE while generating token

Shivaprasad G Bhat (2):
      spapr: drc: Add support for async hcalls at the drc level
      spapr: nvdimm: Implement async flush hcalls


 hw/mem/nvdimm.c            |    1
 hw/ppc/spapr_drc.c         |  146 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nvdimm.c      |   79 ++++++++++++++++++++++++
 include/hw/mem/nvdimm.h    |   10 +++
 include/hw/ppc/spapr.h     |    3 +
 include/hw/ppc/spapr_drc.h |   25 ++++++++
 6 files changed, 263 insertions(+), 1 deletion(-)

--
Signature
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
