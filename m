Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE4204952
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 07:52:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8099010FC4AD2;
	Mon, 22 Jun 2020 22:52:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0182B10FC3777
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 22:52:16 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05N5XPLg097943;
	Tue, 23 Jun 2020 01:52:14 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31u67eyut4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2020 01:52:14 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05N5o9OZ018076;
	Tue, 23 Jun 2020 05:52:13 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma02wdc.us.ibm.com with ESMTP id 31sa38vy3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2020 05:52:12 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05N5qAGU28901882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2020 05:52:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7FA78060;
	Tue, 23 Jun 2020 05:52:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114BC7805F;
	Tue, 23 Jun 2020 05:52:09 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.71.222])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2020 05:52:09 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/2] powerpc/papr_scm: Fetch nvdimm performance stats
 from PHYP
In-Reply-To: <871rm649u0.fsf@linux.ibm.com>
References: <20200622042451.22448-1-vaibhav@linux.ibm.com>
 <20200622042451.22448-2-vaibhav@linux.ibm.com>
 <871rm649u0.fsf@linux.ibm.com>
Date: Tue, 23 Jun 2020 11:22:07 +0530
Message-ID: <87y2oe2ut4.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_01:2020-06-22,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 cotscore=-2147483648 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230043
Message-ID-Hash: PVX7XHWT5ZFGYALU2MNVS4LLZVGCND7U
X-Message-ID-Hash: PVX7XHWT5ZFGYALU2MNVS4LLZVGCND7U
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PVX7XHWT5ZFGYALU2MNVS4LLZVGCND7U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> +		 */
>> +		seq_buf_init(&s, buf, PAGE_SIZE);
>> +		for (index = 0, stat = stats->scm_statistic;
>> +		     index < stats->num_statistics; ++index, ++stat) {
>> +			seq_buf_printf(&s, "%.8s = 0x%016llX\n",
>> +				       stat->statistic_id, stat->statistic_value);
>
>
> That is raw number (statistic_id). Is that useful? Can we map them to user readable
> strings? 

Ok i missed that "%.8s" .

>
>> +		}
>> +	}
>> +
>> +	kfree(stats);
>> +	return rc ? rc : seq_buf_used(&s);
>> +}
>> +DEVICE_ATTR_RO(perf_stats);

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
