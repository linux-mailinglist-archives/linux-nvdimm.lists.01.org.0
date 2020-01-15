Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A713CB21
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 18:35:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 948FB10097DC9;
	Wed, 15 Jan 2020 09:39:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70A2110097DAF
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579109746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmofTfuiU2O7V2z9wfvRSsO1SO0S5EY2fIpmSWDsGKw=;
	b=TtrAO99+m+q4DSOTNCL/pyhRpCzCaTMbglKngWAq6x9TUJHM0xtPwLQ9QMZA/4t0wCEJRI
	KPjMrtC7X6nmQe4xS3qwxiNNcwj9lBZLVRKageyy7dcW5FM1oI1kkZ97roYO0Bis8X2Cn2
	kR/23CP4kqsdu0dGCMFVIxepFNuUfRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-3D8DbsJtOjWcM7klVPXKTw-1; Wed, 15 Jan 2020 12:35:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1E3107B7EA;
	Wed, 15 Jan 2020 17:35:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F4560CD3;
	Wed, 15 Jan 2020 17:35:41 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
	<x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
	<a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 15 Jan 2020 12:35:40 -0500
In-Reply-To: <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com> (Aneesh
	Kumar K. V.'s message of "Wed, 15 Jan 2020 22:57:00 +0530")
Message-ID: <x49k15soc5v.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3D8DbsJtOjWcM7klVPXKTw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: YSVRKEDBIPRG4LDRDL4ESMK6MZRFAJVR
X-Message-ID-Hash: YSVRKEDBIPRG4LDRDL4ESMK6MZRFAJVR
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSVRKEDBIPRG4LDRDL4ESMK6MZRFAJVR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

>> Would you also update of_pmem to indicate the persistence domain,
>> please?
>>
>
> sure.

Thanks!

>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>>> index f2a33f2e3ba8..9126737377e1 100644
>>> --- a/include/linux/libnvdimm.h
>>> +++ b/include/linux/libnvdimm.h
>>> @@ -52,9 +52,9 @@ enum {
>>>   	 */
>>>   	ND_REGION_PERSIST_CACHE = 1,
>>>   	/*
>>> -	 * Platform provides mechanisms to automatically flush outstanding
>>> -	 * write data from memory controler to pmem on system power loss.
>>> -	 * (ADR)
>>> +	 * Platform provides instructions to flush data such that on completion
>>> +	 * of the instructions, data flushed is guaranteed to be on pmem even
>>> +	 * in case of a system power loss.
>>
>> I find the prior description easier to understand.
>
> I was trying to avoid the term 'automatically, 'memory controler' and
> ADR. Can I update the above as

I can understand avoiding the very x86-specific "ADR," but is memory
controller not accurate for your platform?

> /*
>  * Platform provides mechanisms to flush outstanding write data
>  * to pmem on system power loss.
>  */

That's way too broad.  :) The comments are describing the persistence
domain.  i.e. if you get data to $HERE, it is guaranteed to make it out
to stable media.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
