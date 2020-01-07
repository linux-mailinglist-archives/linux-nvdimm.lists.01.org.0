Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16095132F40
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 20:19:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DFD410097DBD;
	Tue,  7 Jan 2020 11:22:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D47D710097DBB
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 11:22:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 4so328305pfz.9
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TU5y0uOd04v29R1ldy4aCdHRn60AIShQAfhIrYqvct4=;
        b=KuhBgkhmzY+be0c7oA/ma8hxZhuoHjFirs176QvXXz/8TxiRr6YQ8GknYwFMLw1MtL
         G5mycKgbz64sOLtaaTynzyLMeFAlctWwoDdtIulNgI4aCVpmcAoiQHuYr8f0bWNv+jqv
         HMu/z7+GvtaFoAMV6thwF4A7WTUJ9Rh4KO08NaZEOaHv52TRRWsWMRLudoMK6W0PHaJx
         OIPAG5RU+91Q4CX0/TyPnG7ydKx5ImuveytiD5wUcjBK9KGUXWJ4XHpEaDPSpM9CljDW
         OiMqRWyN7ID3K0FkcOD4TS+Ieou2h7qp9XyN6u4X/M1xbFRYfk3/iyRYvjiQYb5MpBaN
         fy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TU5y0uOd04v29R1ldy4aCdHRn60AIShQAfhIrYqvct4=;
        b=Bjm7S4qKahZf8owl5tyBjPAhbbWGoBZWWHMySQnPgo70CPR8Bq+xMuGY6VUaaVUTtc
         zG39bZsGsepw40cVNQKlPZpTXLxfMcqjoPrtXc7JyQVFuik3PftbDGbF38N6c9NwpzwH
         adK3TwnkJOAWMPpyEcv8JIQcicAqzK5NumfaQ0CrFvFXPfhaaewiKJCi/YsRMgvNzkfZ
         aPfBEpiDpVXS/nWYE6dH79+B/u5R1BWq90K66dmkhrnWZn1RPeunOZ4BcAGKsSHQy5Ai
         k+J5srKz6lY0utUBzgSbVHYcviNmq8vbyBBw5C3jb9kVj+F/ihP9eHIpnhGwmzw8W2Z4
         Nq3g==
X-Gm-Message-State: APjAAAVutcBm9uku+z2jS4610Aw0eKhv2bgxQts0oYo+cpb/obREMQ0P
	q8wxsHrWQF8lJ71j1tpjNts0Fw==
X-Google-Smtp-Source: APXvYqz3hHvhtKQxlmnApv3yxgqZQM3teHJBcT4UloZ5gm4T7Df1KmGi/QM9c96hmThP+tfqKucIyA==
X-Received: by 2002:a62:f94d:: with SMTP id g13mr825176pfm.60.1578424749010;
        Tue, 07 Jan 2020 11:19:09 -0800 (PST)
Received: from gnomeregan01.cam.corp.google.com ([2620:15c:6:14:50b7:ffca:29c4:6488])
        by smtp.googlemail.com with ESMTPSA id i2sm485165pgi.94.2020.01.07.11.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 11:19:08 -0800 (PST)
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To: Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
 <e012696f-f13e-5af1-2b14-084607d69bfa@google.com>
 <20200107190522.GA16987@linux.intel.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <08a36944-ad5a-ca49-99b3-d3908ce0658b@google.com>
Date: Tue, 7 Jan 2020 14:19:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107190522.GA16987@linux.intel.com>
Content-Language: en-US
Message-ID-Hash: MTDOFTOEJDDKXPW3H4YAQEG5CLRIMDXV
X-Message-ID-Hash: MTDOFTOEJDDKXPW3H4YAQEG5CLRIMDXV
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MTDOFTOEJDDKXPW3H4YAQEG5CLRIMDXV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi -

On 1/7/20 2:05 PM, Sean Christopherson wrote:
> On Mon, Dec 16, 2019 at 11:05:26AM -0500, Barret Rhoden wrote:
>> On 12/13/19 12:19 PM, Sean Christopherson wrote:
>>> Teaching thp_adjust() how to handle 1GB wouldn't be a bad thing.  It's
>>> unlikely THP itself will support 1GB pages any time soon, but having the
>>> logic there wouldn't hurt anything.
>>>
>>
>> Cool.  This was my main concern - I didn't want to break THP.
>>
>> I'll rework the series based on all of your comments.
> 
> Hopefully you haven't put too much effort into the rework, because I want
> to commandeer the proposed changes and use them as the basis for a more
> aggressive overhaul of KVM's hugepage handling.  Ironically, there's a bug
> in KVM's THP handling that I _think_ can be avoided by using the DAX
> approach of walking the host PTEs.
> 
> I'm in the process of testing, hopefully I'll get a series sent out later
> today.  If not, I should at least be able to provide an update.

Nice timing.  I was just about to get back to this, so I haven't put any 
time in yet.  =)

Please CC me, and I'll try your patches out on my end.

Thanks,

Barret


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
