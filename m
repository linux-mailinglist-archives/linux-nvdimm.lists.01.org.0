Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795DA178AF5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 07:53:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4567610FC317D;
	Tue,  3 Mar 2020 22:54:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF7471003E9BE
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 22:54:14 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0246pNhY038393
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 01:53:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yhpwmkh9q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 01:53:22 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Wed, 4 Mar 2020 06:53:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 4 Mar 2020 06:53:12 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0246qDVG43975134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2020 06:52:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C3E04C059;
	Wed,  4 Mar 2020 06:53:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE9434C04A;
	Wed,  4 Mar 2020 06:53:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2020 06:53:10 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A6CBDA023A;
	Wed,  4 Mar 2020 17:53:05 +1100 (AEDT)
Subject: Re: [PATCH v3 18/27] powerpc/powernv/pmem: Add controller dump IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-19-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Wed, 4 Mar 2020 17:53:09 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-19-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030406-0012-0000-0000-0000038CFCD6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030406-0013-0000-0000-000021C9B5FE
Message-Id: <7fc5ee46-d849-11f1-d0ad-429a8c87d7eb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=951 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040052
Message-ID-Hash: IUAQMFQVLYAKYFSJOCVHNYX7RGVAOKSO
X-Message-ID-Hash: IUAQMFQVLYAKYFSJOCVHNYX7RGVAOKSO
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IUAQMFQVLYAKYFSJOCVHNYX7RGVAOKSO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> +static int ioctl_controller_dump_data(struct ocxlpmem *ocxlpmem,
> +		struct ioctl_ocxl_pmem_controller_dump_data __user *uarg)
> +{
> +	struct ioctl_ocxl_pmem_controller_dump_data args;
> +	u16 i;
> +	u64 val;
> +	int rc;
> +
> +	if (copy_from_user(&args, uarg, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.buf_size % 8)
> +		return -EINVAL;
> +
> +	if (args.buf_size > ocxlpmem->admin_command.data_size)
> +		return -EINVAL;
> +
> +	mutex_lock(&ocxlpmem->admin_command.lock);
> +
> +	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_CONTROLLER_DUMP);
> +	if (rc)
> +		goto out;
> +
> +	val = ((u64)args.offset) << 32;
> +	val |= args.buf_size;
> +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> +				      ocxlpmem->admin_command.request_offset + 0x08,
> +				      OCXL_LITTLE_ENDIAN, val);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_execute(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +	rc = admin_command_complete_timeout(ocxlpmem,
> +					    ADMIN_COMMAND_CONTROLLER_DUMP);
> +	if (rc < 0) {
> +		dev_warn(&ocxlpmem->dev, "Controller dump timed out\n");
> +		goto out;
> +	}
> +
> +	rc = admin_response(ocxlpmem);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS) {
> +		warn_status(ocxlpmem,
> +			    "Unexpected status from retrieve error log",

Controller dump

> +			    rc);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < args.buf_size; i += 8) {
> +		u64 val;
> +
> +		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +					     ocxlpmem->admin_command.data_offset + i,
> +					     OCXL_HOST_ENDIAN, &val);

Is a controller dump something where we want to do endian swapping?

Any reason we're not doing the usual check of the data identifier, 
additional data length etc?

> +		if (rc)
> +			goto out;
> +
> +		if (copy_to_user(&args.buf[i], &val, sizeof(u64))) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +	if (copy_to_user(uarg, &args, sizeof(args))) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	rc = admin_response_handled(ocxlpmem);
> +	if (rc)
> +		goto out;
> +
> +out:
> +	mutex_unlock(&ocxlpmem->admin_command.lock);
> +	return rc;
> +}
> +
> +int request_controller_dump(struct ocxlpmem *ocxlpmem)
> +{
> +	int rc;
> +	u64 busy = 1;
> +
> +	rc = ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHIC,
> +				    OCXL_LITTLE_ENDIAN,
> +				    GLOBAL_MMIO_CHI_CDA);

This return code is ignored

> +
> +
> +	rc = ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
> +				    OCXL_LITTLE_ENDIAN,
> +				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP);
> +	if (rc)
> +		return rc;
> +
> +	while (busy) {
> +		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> +					     GLOBAL_MMIO_HCI,
> +					     OCXL_LITTLE_ENDIAN, &busy);
> +		if (rc)
> +			return rc;
> +
> +		busy &= GLOBAL_MMIO_HCI_CONTROLLER_DUMP;
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
