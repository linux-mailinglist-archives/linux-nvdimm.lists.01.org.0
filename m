Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A1164D10
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 18:55:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A67A100780A7;
	Wed, 19 Feb 2020 09:56:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5574E1007B1C3
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582134947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7sz7EWdyJf+soZEx7Q9kI9BEyE1FbIaNgdhECk6FA8=;
	b=d+KgCPUx6XdMs9A9GAm0CjJAxKomwuWdMNPzSH6lrc3CBAVZ8pyHECIw4PgMknbtYXQrYj
	H1A4gkq+PzJnGlN89x+VDhKoPuiPMfc71F2oPMJXXVwIwFmCRt4TfEojTa5DYvdFc8Oco7
	52PQJAt2Ff2/Zhi0waUIOoaPEq18FWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-tmy7Fzl2Nky6y99GAykDjA-1; Wed, 19 Feb 2020 12:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE5028010CA;
	Wed, 19 Feb 2020 17:55:44 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 66CF488859;
	Wed, 19 Feb 2020 17:55:44 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 19 Feb 2020 12:55:43 -0500
In-Reply-To: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Tue, 26 Nov 2019 16:42:07 -0800")
Message-ID: <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tmy7Fzl2Nky6y99GAykDjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 6UKYGW6BEOGYDQVZNL7H6ONATW6XJQWH
X-Message-ID-Hash: 6UKYGW6BEOGYDQVZNL7H6ONATW6XJQWH
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6UKYGW6BEOGYDQVZNL7H6ONATW6XJQWH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> The only expected difference between "ndctl list -R" and "ndctl list
> -Rv" is some additional output fields. Instead it currently results in
> the region array being contained in a named "regions" list object.
>
> # ndctl list -R -r 0
> [
>   {
>     "dev":"region0",
>     "size":4294967296,
>     "available_size":0,
>     "max_available_extent":0,
>     "type":"pmem",
>     "persistence_domain":"unknown"
>   }
> ]
>
> # ndctl list -Rv -r 0
> {
>   "regions":[
>     {
>       "dev":"region0",
>       "size":4294967296,
>       "available_size":0,
>       "max_available_extent":0,
>       "type":"pmem",
>       "numa_node":0,
>       "target_node":2,
>       "persistence_domain":"unknown",
>       "namespaces":[
>         {
>           "dev":"namespace0.0",
>           "mode":"fsdax",
>           "map":"mem",
>           "size":4294967296,
>           "sector_size":512,
>           "blockdev":"pmem0",
>           "numa_node":0,
>           "target_node":2
>         }
>       ]
>     }
>   ]
> }
>
> Drop the named list, by not including namespaces in the listing. Extra
> objects only appear at the -vv level. "ndctl list -v" and "ndctl list
> -Nv" are synonyms and behave as expected.
>
> # ndctl list -Rv -r 0
> [
>   {
>     "dev":"region0",
>     "size":4294967296,
>     "available_size":0,
>     "max_available_extent":0,
>     "type":"pmem",
>     "numa_node":0,
>     "target_node":2,
>     "persistence_domain":"unknown"
>   }
> ]
>

Will this break existing code that parses the javascript output?

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
