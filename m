Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A4DCFF0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:23:17 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 450EE10FCB908;
	Fri, 18 Oct 2019 13:25:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CEC410FCB902
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:25:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0AA918C4276
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C571560BF4
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
	id C380721C9ACF; Fri, 18 Oct 2019 16:23:07 -0400 (EDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl patch 0/4] misc. cleanups
Date: Fri, 18 Oct 2019 16:22:58 -0400
Message-Id: <20191018202302.8122-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Message-ID-Hash: KLBHJRXRDE3V2R2FAJME6MQQ37W7V34B
X-Message-ID-Hash: KLBHJRXRDE3V2R2FAJME6MQQ37W7V34B
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KLBHJRXRDE3V2R2FAJME6MQQ37W7V34B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patches are motivated by warnings from the clang static
analyzer.  They don't fix bugs, and shouldn't result in any changes
in behavior.  The one exception is the fix for building tags tables.

-Jeff

[ndctl patch 1/4] util/abspath: cleanup prefix_filename
[ndctl patch 2/4] fix building of tags tables
[ndctl patch 3/4] query_fw_finish_status: get rid of redundant
[ndctl patch 4/4] load-keys: get rid of duplicate assignment
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
