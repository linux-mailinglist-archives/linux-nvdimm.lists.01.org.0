Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FC182A71
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 09:05:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94AD710FC3781;
	Thu, 12 Mar 2020 01:06:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=patrick.ohly@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B04510FC377C
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 01:06:12 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:21 -0700
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400";
   d="scan'208";a="236744025"
Received: from fpirou-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:18 -0700
From: "Patrick Ohly" <patrick.ohly@intel.com>
To: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
References: <20200304165845.3081-1-vgoyal@redhat.com>
Date: Wed, 11 Mar 2020 14:38:03 +0100
Message-ID: <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Message-ID-Hash: SO2AUCSOYFMJJPKJ4YH4QS76H6D6AMMU
X-Message-ID-Hash: SO2AUCSOYFMJJPKJ4YH4QS76H6D6AMMU
X-MailFrom: patrick.ohly@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SO2AUCSOYFMJJPKJ4YH4QS76H6D6AMMU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vivek Goyal <vgoyal@redhat.com> writes:
> This patch series adds DAX support to virtiofs filesystem. This allows
> bypassing guest page cache and allows mapping host page cache directly
> in guest address space.
>
> When a page of file is needed, guest sends a request to map that page
> (in host page cache) in qemu address space. Inside guest this is
> a physical memory range controlled by virtiofs device. And guest
> directly maps this physical address range using DAX and hence gets
> access to file data on host.
>
> This can speed up things considerably in many situations. Also this
> can result in substantial memory savings as file data does not have
> to be copied in guest and it is directly accessed from host page
> cache.

As a potential user of this, let me make sure I understand the expected
outcome: is the goal to let virtiofs use DAX (for increased performance,
etc.) or also let applications that use virtiofs use DAX?

You are mentioning using the host's page cache, so it's probably the
former and MAP_SYNC on virtiofs will continue to be rejected, right?

-- 
Best Regards

Patrick Ohly
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
