Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484EE231C30
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 11:35:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65590126A2FA1;
	Wed, 29 Jul 2020 02:35:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [63.128.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37C42126A2FA1
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1596015343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N5QoZ3Ws6LHrpC2Hlxw9jhu5yCQdBET49dBgxewxzfc=;
	b=FD1kgn8oRR6OD1L3wZaWl0BttQcrXNmZsrq6VFdNTNx+Q9thKQIp2Y3LgJCFcLi06mf7gu
	ex2yNzqqM/FRExI1UGCaGGqJSv7J3rKhq3OsSze339scW9FN5YqC5AmHFHu8StIce6Ih+m
	bdBTFFWS/Tnk5cw9swr8OpTlUTZaEtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-KiAY3_nvM7-rAC_v0lSuzQ-1; Wed, 29 Jul 2020 05:35:38 -0400
X-MC-Unique: KiAY3_nvM7-rAC_v0lSuzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64871800481;
	Wed, 29 Jul 2020 09:35:34 +0000 (UTC)
Received: from [10.36.114.111] (ovpn-114-111.ams2.redhat.com [10.36.114.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 996E319746;
	Wed, 29 Jul 2020 09:35:22 +0000 (UTC)
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
To: Mike Rapoport <rppt@linux.ibm.com>, Justin He <Justin.He@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63W5Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAjwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
Date: Wed, 29 Jul 2020 11:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729093150.GC3672596@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: LZMJE7IPRU36CCLEXF4BIOP4T5ECZ2X3
X-Message-ID-Hash: LZMJE7IPRU36CCLEXF4BIOP4T5ECZ2X3
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LZMJE7IPRU36CCLEXF4BIOP4T5ECZ2X3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjkuMDcuMjAgMTE6MzEsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IEhpIEp1c3RpbiwNCj4g
DQo+IE9uIFdlZCwgSnVsIDI5LCAyMDIwIGF0IDA4OjI3OjU4QU0gKzAwMDAsIEp1c3RpbiBIZSB3
cm90ZToNCj4+IEhpIERhdmlkDQo+Pj4+DQo+Pj4+IFdpdGhvdXQgdGhpcyBzZXJpZXMsIGlmIHFl
bXUgY3JlYXRlcyBhIDRHIGJ5dGVzIG52ZGltbSBkZXZpY2UsIHdlIGNhbg0KPj4+IG9ubHkNCj4+
Pj4gdXNlIDJHIGJ5dGVzIGZvciBkYXggcG1lbShrbWVtKSBpbiB0aGUgd29yc3QgY2FzZS4NCj4+
Pj4gZS5nLg0KPj4+PiAyNDAwMDAwMDAtMzNmZGZmZmZmIDogUGVyc2lzdGVudCBNZW1vcnkNCj4+
Pj4gV2UgY2FuIG9ubHkgdXNlIHRoZSBtZW1ibG9jayBiZXR3ZWVuIFsyNDAwMDAwMDAsIDJmZmZm
ZmZmZl0gZHVlIHRvIHRoZQ0KPj4+IGhhcmQNCj4+Pj4gbGltaXRhdGlvbi4gSXQgd2FzdGVzIHRv
byBtdWNoIG1lbW9yeSBzcGFjZS4NCj4+Pj4NCj4+Pj4gRGVjcmVhc2luZyB0aGUgU0VDVElPTl9T
SVpFX0JJVFMgb24gYXJtNjQgbWlnaHQgYmUgYW4gYWx0ZXJuYXRpdmUsIGJ1dA0KPj4+IHRoZXJl
DQo+Pj4+IGFyZSB0b28gbWFueSBjb25jZXJucyBmcm9tIG90aGVyIGNvbnN0cmFpbnRzLCBlLmcu
IFBBR0VfU0laRSwgaHVnZXRsYiwNCj4+Pj4gU1BBUlNFTUVNX1ZNRU1NQVAsIHBhZ2UgYml0cyBp
biBzdHJ1Y3QgcGFnZSAuLi4NCj4+Pj4NCj4+Pj4gQmVzaWRlIGRlY3JlYXNpbmcgdGhlIFNFQ1RJ
T05fU0laRV9CSVRTLCB3ZSBjYW4gYWxzbyByZWxheCB0aGUga21lbQ0KPj4+IGFsaWdubWVudA0K
Pj4+PiB3aXRoIG1lbW9yeV9ibG9ja19zaXplX2J5dGVzKCkuDQo+Pj4+DQo+Pj4+IFRlc3RlZCBv
biBhcm02NCBndWVzdCBhbmQgeDg2IGd1ZXN0LCBxZW11IGNyZWF0ZXMgYSA0RyBwbWVtIGRldmlj
ZS4gZGF4DQo+Pj4gcG1lbQ0KPj4+PiBjYW4gYmUgdXNlZCBhcyByYW0gd2l0aCBzbWFsbGVyIGdh
cC4gQWxzbyB0aGUga21lbSBob3RwbHVnIGFkZC9yZW1vdmUNCj4+PiBhcmUgYm90aA0KPj4+PiB0
ZXN0ZWQgb24gYXJtNjQveDg2IGd1ZXN0Lg0KPj4+Pg0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+PiBJ
IGFtIG5vdCBjb252aW5jZWQgdGhpcyB1c2UgY2FzZSBpcyB3b3J0aCBzdWNoIGhhY2tzICh0aGF0
4oCZcyB3aGF0IGl0IGlzKQ0KPj4+IGZvciBub3cuIE9uIHJlYWwgbWFjaGluZXMgcG1lbSBpcyBi
aWcgLSB5b3VyIGV4YW1wbGUgKGxvc2luZyA1MCUgaXMNCj4+PiBleHRyZW1lKS4NCj4+Pg0KPj4+
IEkgd291bGQgbXVjaCByYXRoZXIgd2FudCB0byBzZWUgdGhlIHNlY3Rpb24gc2l6ZSBvbiBhcm02
NCByZWR1Y2VkLiBJDQo+Pj4gcmVtZW1iZXIgdGhlcmUgd2VyZSBwYXRjaGVzIGFuZCB0aGF0IGF0
IGxlYXN0IHdpdGggYSBiYXNlIHBhZ2Ugc2l6ZSBvZiA0aw0KPj4+IGl0IGNhbiBiZSByZWR1Y2Vk
IGRyYXN0aWNhbGx5ICg2NGsgYmFzZSBwYWdlcyBhcmUgbW9yZSBwcm9ibGVtYXRpYyBkdWUgdG8N
Cj4+PiB0aGUgcmlkaWN1bG91cyBUSFAgc2l6ZSBvZiA1MTJNKS4gQnV0IGNvdWxkIGJlIGEgc2Vj
dGlvbiBzaXplIG9mIDUxMiBpcw0KPj4+IHBvc3NpYmxlIG9uIGFsbCBjb25maWdzIHJpZ2h0IG5v
dy4NCj4+DQo+PiBZZXMsIEkgb25jZSBpbnZlc3RpZ2F0ZWQgaG93IHRvIHJlZHVjZSBzZWN0aW9u
IHNpemUgb24gYXJtNjQgdGhvdWdodGZ1bGx5Og0KPj4gVGhlcmUgYXJlIG1hbnkgY29uc3RyYWlu
dHMgZm9yIHJlZHVjaW5nIFNFQ1RJT05fU0laRV9CSVRTDQo+PiAxLiBHaXZlbiBwYWdlLT5mbGFn
cyBiaXRzIGlzIGxpbWl0ZWQsIFNFQ1RJT05fU0laRV9CSVRTIGNhbid0IGJlIHJlZHVjZWQgdG9v
DQo+PiAgICBtdWNoLg0KPj4gMi4gT25jZSBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgZW5h
YmxlZCwgc2VjdGlvbiBpZCB3aWxsIG5vdCBiZSBjb3VudGVkDQo+PiAgICBpbnRvIHBhZ2UtPmZs
YWdzLg0KPj4gMy4gTUFYX09SREVSIGRlcGVuZHMgb24gU0VDVElPTl9TSVpFX0JJVFMgDQo+PiAg
LSAzLjEgbW16b25lLmgNCj4+ICNpZiAoTUFYX09SREVSIC0gMSArIFBBR0VfU0hJRlQpID4gU0VD
VElPTl9TSVpFX0JJVFMNCj4+ICNlcnJvciBBbGxvY2F0b3IgTUFYX09SREVSIGV4Y2VlZHMgU0VD
VElPTl9TSVpFDQo+PiAjZW5kaWYNCj4+ICAtIDMuMiBodWdlcGFnZV9pbml0KCkNCj4+IE1BWUJF
X0JVSUxEX0JVR19PTihIUEFHRV9QTURfT1JERVIgPj0gTUFYX09SREVSKTsNCj4+DQo+PiBIZW5j
ZSB3aGVuIEFSTTY0XzRLX1BBR0VTICYmIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCBhcmUgZW5h
YmxlZCwNCj4+IFNFQ1RJT05fU0laRV9CSVRTIGNhbiBiZSByZWR1Y2VkIHRvIDI3Lg0KPj4gQnV0
IHdoZW4gQVJNNjRfNjRLX1BBR0VTLCBnaXZlbiAzLjIsIE1BWF9PUkRFUiA+IDI5LTE2ID0gMTMu
DQo+PiBHaXZlbiAzLjEgU0VDVElPTl9TSVpFX0JJVFMgPj0gTUFYX09SREVSKzE1ID4gMjguIFNv
IFNFQ1RJT05fU0laRV9CSVRTIGNhbiBub3QNCj4+IGJlIHJlZHVjZWQgdG8gMjcuDQo+Pg0KPj4g
SW4gb25lIHdvcmQsIGlmIHdlIGNvbnNpZGVyZWQgdG8gcmVkdWNlIFNFQ1RJT05fU0laRV9CSVRT
IG9uIGFybTY0LCB0aGUgS2NvbmZpZw0KPj4gbWlnaHQgYmUgdmVyeSBjb21wbGljYXRlZCxlLmcu
IHdlIHN0aWxsIG5lZWQgdG8gY29uc2lkZXIgdGhlIGNhc2UgZm9yDQo+PiBBUk02NF8xNktfUEFH
RVMuDQo+IA0KPiBJdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHBvbGx1dGUgS2NvbmZpZyB3aXRoIHRo
YXQuDQo+IGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vc3BhcmVzZW1lbS5oIGNhbiBoYXZlIHNvbWV0
aGluZyBsaWtlDQo+IA0KPiAjaWZkZWYgQ09ORklHX0FSTTY0XzY0S19QQUdFUw0KPiAjZGVmaW5l
IFNQQVJTRV9TRUNUSU9OX1NJWkUgMjkNCj4gI2VsaWYgZGVmaW5lZChDT05GSUdfQVJNMTZLX1BB
R0VTKQ0KPiAjZGVmaW5lIFNQQVJTRV9TRUNUSU9OX1NJWkUgMjgNCj4gI2VsaWYgZGVmaW5lZChD
T05GSUdfQVJNNEtfUEFHRVMpDQo+ICNkZWZpbmUgU1BBUlNFX1NFQ1RJT05fU0laRSAyNw0KPiAj
ZWxzZQ0KPiAjZXJyb3INCj4gI2VuZGlmDQoNCmFjaw0KDQo+ICANCj4gVGhlcmUgaXMgc3RpbGwg
bGFyZ2UgZ2FwIHdpdGggQVJNNjRfNjRLX1BBR0VTLCB0aG91Z2guDQo+IA0KPiBBcyBmb3IgU1BB
UlNFTUVNIHdpdGhvdXQgVk1FTU1BUCwgYXJlIHRoZXJlIGFjdHVhbCBiZW5lZml0cyB0byB1c2Ug
aXQ/DQoNCkkgd2FzIGFza2luZyBteXNlbGYgdGhlIHNhbWUgcXVlc3Rpb24gYSB3aGlsZSBhZ28g
YW5kIGRpZG4ndCByZWFsbHkgZmluZA0KYSBjb21wZWxsaW5nIG9uZS4NCg0KSSB0aGluayBpdCdz
IGFsd2F5cyBlbmFibGVkIGFzIGRlZmF1bHQgKFNQQVJTRU1FTV9WTUVNTUFQX0VOQUJMRSkgYW5k
DQp3b3VsZCByZXF1aXJlIGNvbmZpZyB0d2Vha3MgdG8gZXZlbiBkaXNhYmxlIGl0Lg0KDQotLSAN
ClRoYW5rcywNCg0KRGF2aWQgLyBkaGlsZGVuYg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
