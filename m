Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777783463A9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 16:54:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E166C100EB83D;
	Tue, 23 Mar 2021 08:54:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=riteshh@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A334100EB83B
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 08:54:35 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NFoTus175024;
	Tue, 23 Mar 2021 11:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h6hBPFYCR+FBgbg4wITQFac+o5L7qJzqrEtyX1BNYFg=;
 b=Mr/2AlA0lcFNJcPQ02PtEP2uPlVx7EwM91gg57lqcnxEAGvBLkVBDXjvyTDq2SENbrbn
 w7kY9ZFXZReS/JN/Z6XN0t+KC48eGhsj+G7RqqOhDNPF3uD6x7f9FJlLWTIbO9HOC52r
 r2K9JYT1MbDv6JURbJYhRXWl62w0ZGgEcNAxLfX+yzD+jihHG8BzkX4fGFmgQX6Rfvy+
 DVwaMvAcdQsbFabbiuQaOTJxxRXGTEscL1GqotqVTsvB/VnBdKQLk7+4K1zmUK/RNSSm
 3KUtn2JuwsS43TOAAdlY8P/eY8T1+l3oEQBAyXI9PmESD7UrT+9hxxaPQoJBKMlg6Dvi 3g==
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37fkaxg6t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 11:54:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NFlK4o029025;
	Tue, 23 Mar 2021 15:54:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04fra.de.ibm.com with ESMTP id 37d9by9ty1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 15:54:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NFs43l34275824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Mar 2021 15:54:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11E142042;
	Tue, 23 Mar 2021 15:54:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4492642045;
	Tue, 23 Mar 2021 15:54:20 +0000 (GMT)
Received: from [9.199.34.65] (unknown [9.199.34.65])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 23 Mar 2021 15:54:20 +0000 (GMT)
Subject: Re: [PATCH v3 03/10] fsdax: Output address in dax_iomap_pfn() and
 rename it
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-4-ruansy.fnst@fujitsu.com>
From: Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <9cf456a0-e2ce-18b2-100a-80604862831b@linux.ibm.com>
Date: Tue, 23 Mar 2021 21:24:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210319015237.993880-4-ruansy.fnst@fujitsu.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_07:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230114
Message-ID-Hash: HTPFK2MHM5OAP5VD4XTKLLQDSQEIEJAQ
X-Message-ID-Hash: HTPFK2MHM5OAP5VD4XTKLLQDSQEIEJAQ
X-MailFrom: riteshh@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HTPFK2MHM5OAP5VD4XTKLLQDSQEIEJAQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 3/19/21 7:22 AM, Shiyang Ruan wrote:
> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/dax.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 

Like the naming convention. It is consistent with
dax_direct_access() function.

Changes looks good to me. Feel free to add.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
