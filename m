Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4391257882
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 13:32:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53CE513999E28;
	Mon, 31 Aug 2020 04:32:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 871FC123C68EC
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 04:32:43 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VBP2hZ048076;
	Mon, 31 Aug 2020 11:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Cqg9rcoPIy2AJj+nZNCXwEbh4UmrOMSGNez48fPV+Go=;
 b=cpHsOTbyGByx6cBVPaGwXsO+9oafPRuTzXdZg97AKcQh5UfNSNGSVpywbIMwCfv7SUet
 3vmJZa+CTh+UxfJCsh0zdWTXWTN/xZyf3Q1d46dlNjc7soDIrOd2U/KSarK3gzZa9dk9
 Q2ryk2uxptgQHBKlVDMrBf1AJvt9ipH0YHccmuuj3UYb2ZMHBSuEBAAfrmsXMTmKH978
 iwmD7XjaSYNXO4++e1JMWF2KBXr/FzoDfMvMpR6f5J5N/upEIvQY2/L6tZDxKUjwlqJO
 lGg4nJYa+1oB4B5VIiBYLkXtjbzy1vJ+HsNnEl6hnHblTxvXwafUl0+MZ5sJMdf/QFNu gw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 337eeqns07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2020 11:32:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VBR8wk129346;
	Mon, 31 Aug 2020 11:32:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 3380kkh055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2020 11:32:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VBWeQZ027904;
	Mon, 31 Aug 2020 11:32:40 GMT
Received: from mwanda (/41.57.98.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 31 Aug 2020 04:32:40 -0700
Date: Mon, 31 Aug 2020 14:32:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: dan.j.williams@intel.com
Subject: [bug report] device-dax: add dis-contiguous resource support
Message-ID: <20200831113235.GA512956@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310065
Message-ID-Hash: TILHYWUFZMSZBGDPUCCJPTOJHHHRA4CJ
X-Message-ID-Hash: TILHYWUFZMSZBGDPUCCJPTOJHHHRA4CJ
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TILHYWUFZMSZBGDPUCCJPTOJHHHRA4CJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dan Williams,

This is a semi-automatic email about new static checker warnings.

The patch 454c727769f5: "device-dax: add dis-contiguous resource
support" from Aug 26, 2020, leads to the following Smatch complaint:

    drivers/dax/bus.c:788 alloc_dev_dax_range()
    error: we previously assumed 'alloc' could be null (see line 772)

drivers/dax/bus.c
   771		alloc = __request_region(res, start, size, dev_name(dev), 0);
   772		if (!alloc && !dev_dax->nr_range) {
                           ^^
This should probably be a ||?

   773			/*
   774			 * If we adjusted an existing @ranges leave it alone,
   775			 * but if this was an empty set of ranges nothing else
   776			 * will release @ranges, so do it now.
   777			 */
   778			kfree(ranges);
   779			return -ENOMEM;
   780		}
   781	
   782		for (i = 0; i < dev_dax->nr_range; i++)
   783			pgoff += PHYS_PFN(range_len(&ranges[i].range));
   784		dev_dax->ranges = ranges;
   785		ranges[dev_dax->nr_range++] = (struct dev_dax_range) {
   786			.pgoff = pgoff,
   787			.range = {
   788				.start = alloc->start,
                                         ^^^^^^^^^^^^
Dereferences.

   789				.end = alloc->end,
   790			},

regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
