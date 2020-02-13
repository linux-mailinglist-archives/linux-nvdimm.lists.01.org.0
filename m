Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9715CAFE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 20:13:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2A7C10FC3384;
	Thu, 13 Feb 2020 11:16:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E5C810FC3380
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581621178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pLLVLig1uc97lbYVaMiWyMB8bq9fPfRpEXIp2spies=;
	b=VvWjEXnOEehlLAePfeYV3Bg+L9PXMI/cHeeoGp3AxX89eA92iqRr887PJ+4yGmWC4f7F3n
	ewhGpC84H0ioi7fOFhjWqY9ddfSTcPjNDGQHVDRMBc064/zFJxg1Mqhi1p0v1t6unqSGAL
	JYGQQQHYB+MoLImuDDrlVEU9/08Jzf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363--OFJ6Y_HN7GijxJy3P8bng-1; Thu, 13 Feb 2020 14:12:53 -0500
X-MC-Unique: -OFJ6Y_HN7GijxJy3P8bng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8270E80259A;
	Thu, 13 Feb 2020 19:12:52 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D634F5C13E;
	Thu, 13 Feb 2020 19:12:51 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/4] libnvdimm/region: Introduce NDD_LABELING
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158155491425.3343782.10431348498314981347.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 13 Feb 2020 14:12:50 -0500
In-Reply-To: <158155491425.3343782.10431348498314981347.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Wed, 12 Feb 2020 16:48:34 -0800")
Message-ID: <x49sgje5mj1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: N2GNMF2H64M5YS7Z6RHHQSM466E3724J
X-Message-ID-Hash: N2GNMF2H64M5YS7Z6RHHQSM466E3724J
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N2GNMF2H64M5YS7Z6RHHQSM466E3724J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> @@ -312,8 +312,9 @@ static ssize_t flags_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	return sprintf(buf, "%s%s\n",
> +	return sprintf(buf, "%s%s%s\n",
>  			test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
> +			test_bit(NDD_LABELING, &nvdimm->flags) ? "label" : "",
                                                                       ^

Missing a space.

The rest looks sane.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
