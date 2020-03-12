Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76451183D21
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 00:14:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 254701007B1EA;
	Thu, 12 Mar 2020 16:15:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD2ED1007B1E6
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 16:15:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CNC52x030945
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 19:14:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yqvw2k27y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 19:14:42 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Thu, 12 Mar 2020 23:14:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 12 Mar 2020 23:14:32 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CNEVfL61603914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2020 23:14:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02F2A4040;
	Thu, 12 Mar 2020 23:14:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C0DA4053;
	Thu, 12 Mar 2020 23:14:31 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2020 23:14:31 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 01057A0218;
	Fri, 13 Mar 2020 10:14:26 +1100 (AEDT)
Subject: Re: [PATCH v3 24/27] powerpc/powernv/pmem: Expose SMART data via
 ndctl
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Date: Fri, 13 Mar 2020 10:14:29 +1100
In-Reply-To: <e68c9064-cb7f-2b5e-9a7b-70fd5367270a@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-25-alastair@au1.ibm.com>
	 <e68c9064-cb7f-2b5e-9a7b-70fd5367270a@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20031223-0008-0000-0000-0000035C4F74
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031223-0009-0000-0000-00004A7D9A8A
Message-Id: <d70936f77cbbf712cee505e7ec009ba1ddaf74e6.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_16:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120113
Message-ID-Hash: B2C3PEKWUC77VZ473WTIWNZGVDT5XDKL
X-Message-ID-Hash: B2C3PEKWUC77VZ473WTIWNZGVDT5XDKL
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxp
 pc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B2C3PEKWUC77VZ473WTIWNZGVDT5XDKL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-03-05 at 14:36 +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> > +static int ndctl_smart(struct ocxlpmem *ocxlpmem, struct
> > nd_cmd_pkg *pkg)
> > +{
> > +	u32 length, i;
> > +	struct nd_ocxl_smart *out;
> > +	int rc;
> > +
> > +	mutex_lock(&ocxlpmem->admin_command.lock);
> > +
> > +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_SMART);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = admin_command_execute(ocxlpmem);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = admin_command_complete_timeout(ocxlpmem,
> > ADMIN_COMMAND_SMART);
> > +	if (rc < 0) {
> > +		dev_err(&ocxlpmem->dev, "SMART timeout\n");
> > +		goto out;
> > +	}
> > +
> > +	rc = admin_response(ocxlpmem);
> > +	if (rc < 0)
> > +		goto out;
> > +	if (rc != STATUS_SUCCESS) {
> > +		warn_status(ocxlpmem, "Unexpected status from SMART",
> > rc);
> > +		goto out;
> > +	}
> > +
> > +	rc = smart_header_parse(ocxlpmem, &length);
> > +	if (rc)
> > +		goto out;
> > +
> > +	pkg->nd_fw_size = length;
> > +
> > +	length = min(length, pkg->nd_size_out); // bytes
> > +	out = (struct nd_ocxl_smart *)pkg->nd_payload;
> > +	// Each SMART attribute is 2 * 64 bits
> > +	out->count = length / (2 * sizeof(u64)); // attributes
> 
>  From what I can tell - 8 bytes of nd_ocxl_smart are taken up for
> the 
> count + reserved bytes, so this is going to potentially overrun the
> user 
> buffer.

Ok

> 
> > +
> > +	for (i = 0; i < length; i += sizeof(u64)) {
> 
> It might be neater to make i count up by 1 and then multiply by 
> sizeof(u64) later.
> 
I tried, it doesn't make much difference to the complexity, and makes
it less clear that we are stepping in 64bit chunks.

> > +		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > +					     ocxlpmem-
> > >admin_command.data_offset + sizeof(u64) + i,
> 
> + 0x08 rather than + sizeof(u64) for consistency.
> 
We use sizeof(u64) in the rest of this function.

> > +					     OCXL_LITTLE_ENDIAN,
> > +					     &out-
> > >attribs[i/sizeof(u64)]);
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	rc = admin_response_handled(ocxlpmem);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = 0;
> > +	goto out;
> > +
> > +out:
> > +	mutex_unlock(&ocxlpmem->admin_command.lock);
> > +	return rc;
> > +}
> > +
> > +static int ndctl_call(struct ocxlpmem *ocxlpmem, void *buf,
> > unsigned int buf_len)
> > +{
> > +	struct nd_cmd_pkg *pkg = buf;
> > +
> > +	if (buf_len < sizeof(struct nd_cmd_pkg)) {
> > +		dev_err(&ocxlpmem->dev, "Invalid ND_CALL size=%u\n",
> > buf_len);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (pkg->nd_family != NVDIMM_FAMILY_OCXL) {
> > +		dev_err(&ocxlpmem->dev, "Invalid ND_CALL
> > family=0x%llx\n", pkg->nd_family);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (pkg->nd_command) {
> > +	case ND_CMD_OCXL_SMART:
> > +		ndctl_smart(ocxlpmem, pkg);
> 
> Did you intend to dispose of the return code here?

Whoops.

> 
> > +		break;
> > +
> > +	default:
> > +		dev_err(&ocxlpmem->dev, "Invalid ND_CALL
> > command=0x%llx\n", pkg->nd_command);
> > +		return -EINVAL;
> > +	}
> > +
> > +
> > +	return 0;
> > +}
> > +
> >   static int ndctl(struct nvdimm_bus_descriptor *nd_desc,
> >   		 struct nvdimm *nvdimm,
> >   		 unsigned int cmd, void *buf, unsigned int buf_len, int
> > *cmd_rc)
> > @@ -88,6 +211,10 @@ static int ndctl(struct nvdimm_bus_descriptor
> > *nd_desc,
> >   	struct ocxlpmem *ocxlpmem = container_of(nd_desc, struct
> > ocxlpmem, bus_desc);
> >   
> >   	switch (cmd) {
> > +	case ND_CMD_CALL:
> > +		*cmd_rc = ndctl_call(ocxlpmem, buf, buf_len);
> > +		return 0;
> > +
> >   	case ND_CMD_GET_CONFIG_SIZE:
> >   		*cmd_rc = ndctl_config_size(buf);
> >   		return 0;
> > @@ -171,6 +298,7 @@ static int register_lpc_mem(struct ocxlpmem
> > *ocxlpmem)
> >   	set_bit(ND_CMD_GET_CONFIG_SIZE, &nvdimm_cmd_mask);
> >   	set_bit(ND_CMD_GET_CONFIG_DATA, &nvdimm_cmd_mask);
> >   	set_bit(ND_CMD_SET_CONFIG_DATA, &nvdimm_cmd_mask);
> > +	set_bit(ND_CMD_CALL, &nvdimm_cmd_mask);
> >   
> >   	set_bit(NDD_ALIASING, &nvdimm_flags);
> >   
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > index 927690f4888f..0eb7a35d24ae 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > @@ -7,6 +7,7 @@
> >   #include <linux/libnvdimm.h>
> >   #include <uapi/nvdimm/ocxl-pmem.h>
> >   #include <linux/mm.h>
> > +#include <linux/ndctl.h>
> >   
> >   #define LABEL_AREA_SIZE	(1UL << PA_SECTION_SHIFT)
> >   #define DEFAULT_TIMEOUT 100
> > @@ -98,6 +99,23 @@ struct ocxlpmem_function0 {
> >   	struct ocxl_fn *ocxl_fn;
> >   };
> >   
> > +struct nd_ocxl_smart {
> > +	__u8 count;
> > +	__u8 reserved[7];
> > +	__u64 attribs[0];
> > +} __packed;
> > +
> > +struct nd_pkg_ocxl {
> > +	struct nd_cmd_pkg gen;
> > +	union {
> > +		struct nd_ocxl_smart smart;
> > +	};
> > +};
> > +
> > +enum nd_cmd_ocxl {
> > +	ND_CMD_OCXL_SMART = 1,
> > +};
> > +
> >   struct ocxlpmem {
> >   	struct device dev;
> >   	struct pci_dev *pdev;
> > diff --git a/include/uapi/linux/ndctl.h
> > b/include/uapi/linux/ndctl.h
> > index de5d90212409..2885052e7f40 100644
> > --- a/include/uapi/linux/ndctl.h
> > +++ b/include/uapi/linux/ndctl.h
> > @@ -244,6 +244,7 @@ struct nd_cmd_pkg {
> >   #define NVDIMM_FAMILY_HPE2 2
> >   #define NVDIMM_FAMILY_MSFT 3
> >   #define NVDIMM_FAMILY_HYPERV 4
> > +#define NVDIMM_FAMILY_OCXL 6
> >   
> >   #define ND_IOCTL_CALL			_IOWR(ND_IOCTL,
> > ND_CMD_CALL,\
> >   					struct nd_cmd_pkg)
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
