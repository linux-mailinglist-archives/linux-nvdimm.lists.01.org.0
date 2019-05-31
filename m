Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6C30A31
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 10:24:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 267D92128D6A3;
	Fri, 31 May 2019 01:24:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=79.96.170.134; helo=cloudserver094114.home.pl;
 envelope-from=rjw@rjwysocki.net; receiver=linux-nvdimm@lists.01.org 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 88E64212794BB
 for <linux-nvdimm@lists.01.org>; Fri, 31 May 2019 01:23:58 -0700 (PDT)
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 59d5adea62202d2a; Fri, 31 May 2019 10:23:55 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
Date: Fri, 31 May 2019 10:23:55 +0200
Message-ID: <4965161.Uu1Nigf0I0@kreacher>
In-Reply-To: <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
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
Cc: linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Friday, May 31, 2019 12:59:27 AM CEST Dan Williams wrote:
> As a single source file object there is no need for the hmat enabling to
> have its own directory.

Well, I asked Keith to add that directory as the code in hmat.c is more related to mm than to
the rest of the ACPI subsystem.

Is there any problem with retaining it?



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
