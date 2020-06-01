Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916EF1EA35B
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 14:02:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D02E100DDCC0;
	Mon,  1 Jun 2020 04:58:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE77A100DEFFD
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 04:58:12 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 051C21KT085887;
	Mon, 1 Jun 2020 08:02:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31d0ns97xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:02:07 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 051C22SM085957;
	Mon, 1 Jun 2020 08:02:02 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31d0ns97q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:02:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 051C0aQe025954;
	Mon, 1 Jun 2020 12:01:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma05fra.de.ibm.com with ESMTP id 31bf481m2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 12:01:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 051C0OoI54853974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2020 12:00:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFE7A406D;
	Mon,  1 Jun 2020 12:01:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB21FA4057;
	Mon,  1 Jun 2020 12:01:32 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.104.164])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon,  1 Jun 2020 12:01:32 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 01 Jun 2020 17:31:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v8 2/5] seq_buf: Export seq_buf_printf
In-Reply-To: <20200527041244.37821-3-vaibhav@linux.ibm.com>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com> <20200527041244.37821-3-vaibhav@linux.ibm.com>
Date: Mon, 01 Jun 2020 17:31:31 +0530
Message-ID: <87367f9eqs.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_07:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1015 cotscore=-2147483648 malwarescore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010087
Message-ID-Hash: QVTIA347YUFQ36YYXCFBNUG3FAPZYYYW
X-Message-ID-Hash: QVTIA347YUFQ36YYXCFBNUG3FAPZYYYW
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Cezary Rojewski <cezary.rojewski@intel.com>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QVTIA347YUFQ36YYXCFBNUG3FAPZYYYW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Christoph and Steven,

Have addressed your review comment to update the patch description and
title for this patch. Can you please provide your ack to this patch.

Thanks,
~ Vaibhav

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> 'seq_buf' provides a very useful abstraction for writing to a string
> buffer without needing to worry about it over-flowing. However even
> though the API has been stable for couple of years now its still not
> exported to kernel loadable modules limiting its usage.
>
> Hence this patch proposes update to 'seq_buf.c' to mark
> seq_buf_printf() which is part of the seq_buf API to be exported to
> kernel loadable GPL modules. This symbol will be used in later parts
> of this patch-set to simplify content creation for a sysfs attribute.
>
> Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v7..v8:
> * Updated the patch title [ Christoph Hellwig ]
> * Updated patch description to replace confusing term 'external kernel
>   modules' to 'kernel lodable modules'.
>
> Resend:
> * Added ack from Steven Rostedt
>
> v6..v7:
> * New patch in the series
> ---
>  lib/seq_buf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 4e865d42ab03..707453f5d58e 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -91,6 +91,7 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(seq_buf_printf);
>  
>  #ifdef CONFIG_BINARY_PRINTF
>  /**
> -- 
> 2.26.2
>
-- 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
